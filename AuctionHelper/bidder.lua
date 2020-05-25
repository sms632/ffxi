_addon = {
    name = 'Bidder',
    author = 'Cair',
    version = '1.0',
    command = 'bidder',
}


local packets = require('packets')
local res = require('resources')
local zone = windower.ffxi.get_info().zone
local ah_zone = {}
local mh_zones = {}

local lc_names = {
    english = {},
    log = {}
}

for k, v in pairs(res.items) do
    local english = v.english:lower()
    local log = v.enl
    lc_names.english[english] = v
    lc_names.log[log] = v
end

local ah_packet     = string.char(0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x01, 0x00)
                                .. string.char(0):rep(42)
local mh_packet     = string.char(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00)
local dbox_packet   = string.char(0x00, 0x00, 0x00, 0x00, 0x0E, 0xFF, 0xFF, 0xFF, 
                                  0xFF, 0xFF, 0xFF, 0xFF, 0x01, 0xFF, 0xFF, 0xFF, 
                                  0x00, 0x00, 0x00, 0x00)
local obox_packet   = string.char(0x00, 0x00, 0x00, 0x00, 0x0D, 0xFF, 0xFF, 0xFF, 
                                  0xFF, 0xFF, 0xFF, 0xFF, 0x01, 0xFF, 0xFF, 0xFF, 
                                  0x00, 0x00, 0x00, 0x00)

local open_ah = function()
    windower.packets.inject_incoming(0x4c, ah_packet)
end

local open_mh = function()
    windower.packets.inject_incoming(0x2D, mh_packet)
end

local open_obox = function()
   windower.packets.inject_incoming(0x4b, obox_packet)
end

local open_dbox = function()
    windower.packets.inject_incoming(0x4b, dbox_packet)
end

local find_item_id = function(name)
    if type(name) == 'number' then
        return name
    end

    local l_name = name and name:lower()

    return lc_names.english[l_name] or lc_names.log[l_name] or false
end

local parse_bool_string = function(str)
    local str = str and str:lower()

    if str == '1' or str == 'stack' then
        return true, true
    elseif str == '0' or str == 'single' then
        return true, false
    end

    return false
end

local place_bid = function(item, stack, price)
    local item = find_item_id(item)
    local matched, stack = parse_bool_string(stack)
    local price = tonumber(price)

    if not item or not matched or not price then
        return 'Invalid args, expected <item> <stack> <price>'
    end

    if item.flags['No Auction'] then
        return 'That item cannot be placed on the auction house'
    end
    
    local inject = packets.new('outgoing',0x4e, {
            ['Type'] = 0x0E,
            ['Slot'] = 0x07,
            ['Price'] = price,
            ['Item'] = item.id,
            ['Stack'] = not stack,
        }, 0x0E)

    packets.inject(inject)
end

local print_help_text = function()
    print('help text')
end

local handlers = {
    help = { print_help_text, false },
    ah = { open_ah, true },
    buy = { place_bid, true },
    mog = { open_mh, true },
    obox = { open_obox, true },
    dbox = { open_dbox, true },
}

local unify_handler = function(handle, cmd, ...)
    local cmd = cmd and cmd:lower() or 'help'

    if handlers[cmd] and (handle or handlers[cmd][2]) then
        local msg = handlers[cmd][1](...)

        if msg then 
            print(msg)
        end
        return true
    elseif handle then
        print('Unrecognized command:', cmd)
    end
end

windower.register_event('addon command', function(cmd, ...) unify_handler(true, cmd, ...) end)
windower.register_event('unhandled command', function(cmd, ...) return unify_handler(false, cmd, ...) end)
windower.register_event('zone change', function(new) zone = new end)