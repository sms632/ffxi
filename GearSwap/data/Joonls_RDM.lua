
--[[
        Custom commands:

        Becasue /sch can be a thing... I've opted to keep this part 

        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar addendum           Addendum: White         Addendum: Black
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off for locking of weapons
        gs c toggle idlemode            Toggles between Refresh, DT and MDT idle mode.
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
        gs c toggle mainweapon			cycles main weapons in the list you defined below
		gs c toggle subweapon			cycles main weapons in the list you defined below

        Casting functions:
        these are to set fewer macros (1 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle                 Cycles element type for nuking
        gs c nuke cycledown             Cycles element type for nuking in reverse order    
		gs c nuke enspellup             Cycles element type for enspell
		gs c nuke enspelldown			Cycles element type for enspell in reverse order 

        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
        gs c nuke helix                 Cast helix2 nuke of saved element 
        gs c nuke storm                 Cast Storm buff of saved element  if /sch
		gs c nuke enspell				Cast enspell of saved enspell element		

        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob				Toggles the Job section of the HUD on or off
        gs c hud lite					Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file. Also on CTRL-END

        // OPTIONAL IF YOU WANT / NEED to skip the cycles...  
        gs c nuke Ice                   Set Element Type to Ice DO NOTE the Element needs a Capital letter. 
        gs c nuke Air                   Set Element Type to Air DO NOTE the Element needs a Capital letter. 
        gs c nuke Dark                  Set Element Type to Dark DO NOTE the Element needs a Capital letter. 
        gs c nuke Light                 Set Element Type to Light DO NOTE the Element needs a Capital letter. 
        gs c nuke Earth                 Set Element Type to Earth DO NOTE the Element needs a Capital letter. 
        gs c nuke Lightning             Set Element Type to Lightning DO NOTE the Element needs a Capital letter. 
        gs c nuke Water                 Set Element Type to Water DO NOTE the Element needs a Capital letter. 
        gs c nuke Fire                  Set Element Type to Fire DO NOTE the Element needs a Capital letter. 
--]]

include('organizer-lib') -- optional
res = require('resources')
texts = require('texts')
include('Modes.lua')

-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('refresh', 'dt', 'mdt')
meleeModes = M('stp', 'normal', 'acc', 'dt', 'mdt')
nukeModes = M('normal', 'acc')

------------------------------------------------------------------------------------------------------
-- Important to read!
------------------------------------------------------------------------------------------------------
-- This will be used later down for weapon combos, here's mine for example, you can add your REMA+offhand of choice in there
-- Add you weapons in the Main list and/or sub list.
-- Don't put any weapons / sub in your IDLE and ENGAGED sets'
-- You can put specific weapons in the midcasts and precast sets for spells, but after a spell is 
-- cast and we revert to idle or engaged sets, we'll be checking the following for weapon selection. 
-- Defaults are the first in each list

mainWeapon = M('Crocea Mors', 'Naegling', 'Kaja Rod')
subWeapon = M('Tauret', 'Machaera +3', 'Daybreak', 'Sors Shield', 'Ammurapi Shield')
------------------------------------------------------------------------------------------------------

----------------------------------------------------------
-- Auto CP Cape: Will put on CP cape automatically when
-- fighting Apex mobs and job is not mastered
----------------------------------------------------------
CP_CAPE = "Mecisto. Mantle" -- Put your CP cape here
----------------------------------------------------------

-- Setting this to true will stop the text spam, and instead display modes in a UI.
-- Currently in construction.
use_UI = true
hud_x_pos = 2000    --important to update these if you have a smaller screen
hud_y_pos = 800     --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 14
hud_transparency = 200 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Impact'


-- Setup your Key Bindings here:
	windower.send_command('bind insert gs c nuke cycle')        -- insert to Cycles Nuke element
	windower.send_command('bind delete gs c nuke cycledown')    -- delete to Cycles Nuke element in reverse order   
	windower.send_command('bind f9 gs c toggle idlemode')       -- F9 to change Idle Mode    
	windower.send_command('bind f7 gs c toggle meleemode')      -- F7 to change Melee Mode  
	windower.send_command('bind !f9 gs c toggle melee') 		-- Alt-F9 Toggle Melee mode on / off, locking of weapons
	windower.send_command('bind !f8 gs c toggle mainweapon')	-- Alt-F8 Toggle Main Weapon
	windower.send_command('bind ^f8 gs c toggle subweapon')		-- CTRL-F8 Toggle sub Weapon.
	windower.send_command('bind !` input /ws "Sanguine Blade" <t>') 		-- Alt-` Sanguine Blade Shortcut.
	windower.send_command('bind !q input /ws "Seraph Blade" <t>') 			-- Alt-q Seraph Blade Shortcut.
	windower.send_command('bind home gs c nuke enspellup')		-- Home Cycle Enspell Up
	windower.send_command('bind PAGEUP gs c nuke enspelldown')  -- PgUP Cycle Enspell Down
	windower.send_command('bind ^f10 gs c toggle mb')           -- F10 toggles Magic Burst Mode on / off.
	windower.send_command('bind !f10 gs c toggle nukemode')		-- Alt-F10 to change Nuking Mode
	windower.send_command('bind F10 gs c toggle matchsc')		-- CTRL-F10 to change Match SC Mode      	
	windower.send_command('bind !end gs c hud lite')            -- Alt-End to toggle light hud version       
	windower.send_command('bind ^end gs c hud keybinds')        -- CTRL-End to toggle Keybinds  

--[[
    This gets passed in when the Keybinds is turned on.
    IF YOU CHANGED ANY OF THE KEYBINDS ABOVE, edit the ones below so it can be reflected in the hud using the "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_melee'] = '(F7)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_mainweapon'] = '(ALT-F8)'
keybinds_on['key_bind_subweapon'] = '(CTRL-F8)'
keybinds_on['key_bind_element_cycle'] = '(INS + DEL)'
keybinds_on['key_bind_enspell_cycle'] = '(HOME + PgUP)'
keybinds_on['key_bind_lock_weapon'] = '(ALT-F9)'
keybinds_on['key_bind_matchsc'] = '(F10)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind insert')
    send_command('unbind delete')	
    send_command('unbind f9')
    send_command('unbind !f9')
    send_command('unbind f8')
    send_command('unbind !f8')
    send_command('unbind ^f8')
    send_command('unbind f10')
    send_command('unbind f12')
    send_command('unbind !`')
    send_command('unbind home')
    send_command('unbind !f10')	
    send_command('unbind `f10')
    send_command('unbind !end')  
    send_command('unbind ^end')  	
end

include('RDM_Lib.lua')

-- Optional. Swap to your sch macro sheet / book
set_macros(1,4) -- Sheet, Book

refreshType = idleModes[1] -- leave this as is     

-- Setup your Gear Sets below:
function get_sets()
    
    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty

	-- Fill this with your own JSE. 
    --Atrophy
    AF.Head		=	"Atro.Chapeau +2"
    AF.Body		=	"Atrophy Tabard +3"
    AF.Hands	=	"Atrophy Gloves +2"
    AF.Legs		=	"Atrophy Tights +2"
    AF.Feet		=	"Atrophy Boots"

    --Vitiation
    RELIC.Head		=	"Viti. Chapeau +2"
    RELIC.Body		=	"Viti. Tabard +1"
    RELIC.Hands 	=	"Viti. Gloves"
    RELIC.Legs		=	"Viti. Tights +2"
    RELIC.Feet		=	"Vitiation Boots"

    --Lethargy
    EMPY.Head		=	"Leth. Chappel"
    EMPY.Body		=	"Lethargy Sayon"
    EMPY.Hands		=	"Leth. Gantherots +1"
    EMPY.Legs		=	"Leth. Fuseau +1"
    EMPY.Feet		=	"Leth. Houseaux +1"

    -- Capes:
    -- Sucellos's And such, add your own.
    RDMCape = {}
    RDMCape.TP		=	{ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
    RDMCape.MACC	=	{ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+6','"Mag.Atk.Bns."+10','Damage taken-5%',}}

	-- SETS
     
    sets.me = {}        		-- leave this empty
    sets.buff = {} 			-- leave this empty
    sets.me.idle = {}			-- leave this empty
    sets.me.melee = {}          	-- leave this empty
    sets.weapons = {}			-- leave this empty
	
    -- Optional 
    --include('AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 

    -- Leave weapons out of the idles and melee sets. You can/should add weapons to the casting sets though
    -- Your idle set
    sets.me.idle.refresh = {
        ammo		=	"Homiliary",
        head		=	RELIC.Head,
        body		=	"Jhakri robe +2",
        hands		=	"Aya. Manopolas +2",
        legs		=	"Carmine Cuisses +1",
        feet		=	"Aya. Gambieras +2",
        neck		=	"Twilight Torque",
        waist		=	"Flume Belt",
        left_ear	=	"Etiolation Earring",
        right_ear	=	"Ethereal Earring",
        left_ring	=	"Stikini Ring +1",
        right_ring	=	"Defending Ring",
        back		=	{ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+6','"Mag.Atk.Bns."+10','Damage taken-5%',}},
    }

    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle.refresh,{
        neck		=	"Twilight Torque",
        head		=	"Malignance Chapeau",
        body		=	"Ayanmo Corazza +2",
        hands		=	"Malignance Gloves",
        legs		=	RELIC.Legs,
        feet		=	"Aya. Gambieras +2",
		left_ring	=	{ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -6%',}},
        right_ring	=	"Defending Ring",
    })  
    sets.me.idle.mdt = set_combine(sets.me.idle.refresh,{

    })  
	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    sets.me.latent_refresh = {waist="Fucho-no-obi"}     
    
	-- Combat Related Sets
	------------------------------------------------------------------------------------------------------
	-- Dual Wield sets
	------------------------------------------------------------------------------------------------------
    sets.me.melee.normaldw = set_combine(sets.me.idle.refresh, {
		ammo		=	"Ginsen",
		head		=	"Malignance Chapeau",
		body		=	"Ayanmo Corazza +2",
		hands		=	"Aya. Manopolas +2",
		legs		=	"Aya. Cosciales +2",
		feet		=	{ name="Taeon Boots", augments={'Attack+15','"Dual Wield"+5','Sklchn.dmg.+3%',}},
		neck		=	"Clotharius Torque",
		waist		=	"Windbuffet Belt",
		left_ear	=	"Dedition Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Petrov Ring",
		right_ring	=	"Rajas Ring",
		back		=	{ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
	})
	
	sets.me.melee.stpdw = set_combine(sets.me.idle.refresh, {
		ammo		=	"Ginsen",
		head		=	"Malignance Chapeau",
		body		=	"Ayanmo Corazza +2",
		hands		=	"Malignance Gloves",
		legs		=	"Aya. Cosciales +2",
		feet		=	{ name="Taeon Boots", augments={'Attack+15','"Dual Wield"+5','Sklchn.dmg.+3%',}},
		neck		=	"Anu Torque",
		waist		=	"Windbuffet Belt",
		left_ear	=	"Sherida Earring",
		right_ear	=	"Dedition Earring",
		left_ring	=	"Petrov Ring",
		right_ring	=	"Rajas Ring",
		back		=	{ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
	})
	
    sets.me.melee.accdw = set_combine(sets.me.melee.normaldw,{
	
    })
	
    sets.me.melee.dtdw = set_combine(sets.me.melee.normaldw,{
        neck		=	"Twilight Torque",
        head		=	"Malignance Chapeau",
        body		=	"Ayanmo Corazza +2",
        hands		=	"Malignance Gloves",
        legs		=	"Ayanmo Cosciales +2",
        feet		=	"Aya. Gambieras +2",
		left_ring	=	"Ayanmo Ring",
        right_ring	=	"Defending Ring",
    })
	
    sets.me.melee.mdtdw = set_combine(sets.me.melee.normaldw,{

    })
	------------------------------------------------------------------------------------------------------
	-- Single Wield sets. -- combines from DW sets
	-- So canjust put what will be changing when off hand is a shield
 	------------------------------------------------------------------------------------------------------   
    sets.me.melee.normalsw = set_combine(sets.me.melee.normaldw,{   
        legs		=	RELIC.Legs,
    })
    sets.me.melee.accsw = set_combine(sets.me.melee.accdw,{

    })
    sets.me.melee.dtsw = set_combine(sets.me.melee.dtdw,{

    })
    sets.me.melee.mdtsw = set_combine(sets.me.melee.mdtdw,{

    })
	sets.me.melee.stpsw = set_combine(sets.me.melee.mdtdw,{

    })
	
	------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
	------------------------------------------------------------------------------------------------------
    sets.me["Savage Blade"] = {
		ammo		=	"Ginsen",
		head		=	"Jhakri Coronal +2",
		body		=	"Jhakri Robe +2",
		hands		=	"Jhakri Cuffs +2",
		legs		=	"Jhakri Slops +2",
		feet		=	"Jhakri Pigaches +2",
		neck		=	"Fotia Gorget",
		waist		=	"Fotia Belt",
		left_ear	=	{ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear	=	"Brutal Earring",
		left_ring	=	"Petrov Ring",
		right_ring	=	"Rajas Ring",
		back={ name	=	"Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	}
    sets.me["Black Halo"] = {
        ammo        =   "Regal Gem",
        head        =   RELIC.Head,
        body        =   RELIC.Body,
        hands       =   AF.Hands,
        legs        =   RELIC.Legs,
        feet        =   "Jhakri Pigaches +2",
        neck        =   "Dls. Torque +2",
        waist       =   "Prosilio Belt +1",
        left_ear    =   { name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
        right_ear   =   "Ishvara Earring",
        left_ring   =   "Stikini Ring +1",
        right_ring  =   "Rufescent Ring",
        back        =   RDMCape.MACC,
    }
    sets.me["Requiescat"] = {
		ammo		=	"Ginsen",
		head		=	"Jhakri Coronal +2",
		body		=	"Jhakri Robe +2",
		hands		=	"Jhakri Cuffs +2",
		legs		=	"Jhakri Slops +2",
		feet		=	"Jhakri Pigaches +2",
		neck		=	"Fotia Gorget",
		waist		=	"Fotia Belt",
		left_ear	=	{ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear	=	"Brutal Earring",
		left_ring	=	"Petrov Ring",
		right_ring	=	"Rajas Ring",
		back={ name	=	"Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	}
    sets.me["Chant du Cygne"] = {
		ammo		=	"Ginsen",
		head		=	"Jhakri Coronal +2",
		body		=	"Jhakri Robe +2",
		hands		=	"Jhakri Cuffs +2",
		legs		=	"Jhakri Slops +2",
		feet		=	"Jhakri Pigaches +2",
		neck		=	"Fotia Gorget",
		waist		=	"Fotia Belt",
		left_ear	=	{ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear	=	"Brutal Earring",
		left_ring	=	"Petrov Ring",
		right_ring	=	"Rajas Ring",
		back={ name	=	"Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	}
	
    sets.me["Sanguine Blade"] = {
		ammo		=	"Ghastly Tathlum +1",
		head		=	"Pixie Hairpin +1",
		body		=	"Jhakri Robe +2",
		hands		=	"Jhakri Cuffs +2",
		legs		=	{ name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+30','Enmity-4','INT+10','Mag. Acc.+15',}},
		feet		=	{ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck		=	"Eddy Necklace",
		waist		=	"Refoccilation Stone",
		left_ear	=	"Friomisi Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Acumen Ring",
		right_ring	=	"Strendu Ring",
		back		=	{ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	}
	
    sets.me["Red Lotus Blade"] = {
		ammo		=	"Ghastly Tathlum +1",
		head		=	{ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body		=	"Jhakri Robe +2",
		hands		=	"Jhakri Cuffs +2",
		legs		=	{ name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+30','Enmity-4','INT+10','Mag. Acc.+15',}},
		feet		=	{ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck		=	"Eddy Necklace",
		waist		=	"Refoccilation Stone",
		left_ear	=	"Friomisi Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Acumen Ring",
		right_ring	=	"Strendu Ring",
		back		=	{ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	}
	
    sets.me["Seraph Blade"] = {
		ammo		=	"Ghastly Tathlum +1",
		head		=	{ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body		=	"Jhakri Robe +2",
		hands		=	"Jhakri Cuffs +2",
		legs		=	{ name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+30','Enmity-4','INT+10','Mag. Acc.+15',}},
		feet		=	{ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck		=	"Eddy Necklace",
		waist		=	"Refoccilation Stone",
		left_ear	=	"Friomisi Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Acumen Ring",
		right_ring	=	"Weather. Ring",
		back		=	{ name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	}
    sets.me["Empyreal Arrow"] = {
		head		=	"Malignance Chapeau",
		body		=	"Jhakri Robe +2",
		hands		=	"Malignance Gloves",
		legs		=	"Jhakri Slops +2",
		feet		=	"Jhakri Pigaches +2",
		neck		=	"Fotia Gorget",
		waist		=	"Fotia Belt",
		left_ear	=	{ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear	=	"Brutal Earring",
		left_ring	=	"Petrov Ring",
		right_ring	=	"Rajas Ring",
		back={ name	=	"Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	}
    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though 
	
	
    ---------------
    -- Casting Sets
    ---------------
    sets.precast = {}   		-- Leave this empty  
    sets.midcast = {}    		-- Leave this empty  
    sets.aftercast = {}  		-- Leave this empty  
    sets.midcast.nuking = {}		-- leave this empty
    sets.midcast.MB	= {}		-- leave this empty   
    sets.midcast.enhancing = {} 	-- leave this empty   
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast RDM need 50 pre JP 42 at master
    sets.precast.casting = {
        main		=	"Crocea Mors",		--20
		head		=	"Atro. Chapeau +2", -- 14
		body		=	{ name="Vitiation Tabard", augments={'Enhances "Chainspell" effect',}}, --12
		hands		=	{ name="Chironic Gloves", augments={'Spell interruption rate down -10%','CHR+6','Mag. Acc.+13','"Mag.Atk.Bns."+11',}}, --30 sird
		legs		=	{ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}}, --7
		feet		=	{ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+21','"Fast Cast"+6','CHR+8','Mag. Acc.+6',}}, --11
        waist		=	"Witful Belt",          --3
    }											--Total: 71 -- To Do: overkill need to slot DT / HP 

    sets.precast["Stun"] = set_combine(sets.precast.casting,{

    })
	
	sets.precast["Impact"] = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting,{

    })
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{

    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
		back		=	"Pahtli Cape",
        feet		=	"Telchine Pigaches",
    })
      
    ---------------------
    -- Ability Precasting
    ---------------------

    sets.precast["Chainspell"] = {body = RELIC.Body}
	 

	
	----------
    -- Midcast
    ----------
	
    -- Just go make it, inventory will thank you and making rules for each is meh.
    sets.midcast.Obi = {
    	waist="Hachirin-no-Obi",
    }
    sets.midcast.Orpheus = {
        --waist="Orpheus's Sash", -- Commented cause I dont have one yet
    }  
	-----------------------------------------------------------------------------------------------
	-- Helix sets automatically derives from casting sets. SO DONT PUT ANYTHING IN THEM other than:
	-- Pixie in DarkHelix
	-- Belt that isn't Obi.
	-----------------------------------------------------------------------------------------------
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.DarkHelix = {
		head		=	"Pixie Hairpin +1",
		waist		=	"Refoccilation Stone",
		left_ring	=	"Archon Ring",
    }
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.Helix = {
		waist		=	"Refoccilation Stone",
    }	

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {   
        main		=	"Maxentius",
        sub			=	"Ammurapi Shield",
        ammo		=	"Pemphredo Tathlum",
        --head		=	Merl.Head.ACC,
        --body		=	Amal.Body.A,
        --hands		=	Amal.Hands.D,
        --legs		=	Amal.Legs.A,
        --feet		=	Amal.Feet.A,
        neck		=	"Dls. Torque",
        waist		=	"Refoccilation Stone",
        left_ear	=	"Friomisi Earring",
        right_ear	=	"Enchntr. Earring +1",
        back		=	RDMCape.MACC,
        right_ring	=	"Freke Ring",
        left_ring	=	"Shiva Ring", 
    }

    sets.midcast.nuking.normal = {
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body="Ea Houppelande",
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs="Ea Slops",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+9%','INT+9','"Mag.Atk.Bns."+10',}},
		neck="Mizu. Kubikazari",
		waist="Refoccilation Stone",
		left_ear="Static Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Mujin Band",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+6','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	sets.midcast["Impact"] = set_combine(sets.midcast.nuking.normal, {head=empty,body="Twilight Cloak"})
	
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
        left_ring	=	"Mujin Band",
        neck		=	"Mizu. Kubikazari",
        right_ring	=	"Locus Ring",
    })
	
    sets.midcast.nuking.acc = {
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body="Ea Houppelande",
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs="Ea Slops",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+9%','INT+9','"Mag.Atk.Bns."+10',}},
		neck="Mizu. Kubikazari",
		waist="Refoccilation Stone",
		left_ear="Static Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Mujin Band",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+6','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.acc, {
        left_ring	=	"Mujin Band",
        neck		=	"Mizu. Kubikazari",
        right_ring	=	"Locus Ring",
    })	
	
    -- Enfeebling

	sets.midcast.Enfeebling = {} -- leave Empty
	--Type A-pure macc no potency mod
    sets.midcast.Enfeebling.macc = {
		range		=	"Kaja Bow",
		head		=	AF.Head,
		body		=	AF.Body,
		hands		=	{ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs		=	{ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet		=	{ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck		=	"Duelist's Torque",
		waist		=	"Eschan Stone",
		left_ear	=	"Malignance Earring",
		right_ear	=	"Gwati Earring",
		left_ring	=	"Weather. Ring",
		right_ring	=	"Jhakri Ring",
		back		=	{ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+6','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	sets.midcast["Stun"] = set_combine(sets.midcast.Enfeebling.macc, {

	})
	
	sets.midcast["Dia III"] = set_combine(sets.midcast.Enfeebling.macc, {
		head="Wh. Rarab Cap +1",
		hands={ name="Chironic Gloves", augments={'Sklchn.dmg.+3%','STR+4','"Treasure Hunter"+2',}},
		waist="Chaac Belt",
	})
	
	--Type B-potency from: Mnd & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.mndpot = {
		range		=	"Kaja Bow",
		head		=	AF.Head,
		body		=	AF.Body,
		hands		=	{ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs		=	{ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet		=	{ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck		=	"Duelist's Torque",
		waist		=	"Eschan Stone",
		left_ear	=	"Malignance Earring",
		right_ear	=	"Gwati Earring",
		left_ring	=	"Weather. Ring",
		right_ring	=	"Jhakri Ring",
		back		=	{ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+6','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	-- Type C-potency from: Int & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.intpot = {
		range		=	"Kaja Bow",
		head		=	AF.Head,
		body		=	AF.Body,
		hands		=	{ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs		=	{ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet		=	{ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck		=	"Duelist's Torque",
		waist		=	"Eschan Stone",
		left_ear	=	"Malignance Earring",
		right_ear	=	"Gwati Earring",
		left_ring	=	"Weather. Ring",
		right_ring	=	"Jhakri Ring",
		back		=	{ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+6','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	--Type D-potency from: Enfeeb Skill & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.skillpot = {
		range		=	"Kaja Bow",
		head		=	AF.Head,
		body		=	AF.Body,
		hands		=	{ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs		=	{ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet		=	{ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck		=	"Duelist's Torque",
		waist		=	"Eschan Stone",
		left_ear	=	"Malignance Earring",
		right_ear	=	"Gwati Earring",
		left_ring	=	"Weather. Ring",
		right_ring	=	"Jhakri Ring",
		back		=	{ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+6','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	-- Tpe E-potency from: Enfeeb skill, Mnd, & "Enfeeb Potency" gear
    sets.midcast.Enfeebling.skillmndpot = {
		range		=	"Kaja Bow",
		head		=	AF.Head,
		body		=	AF.Body,
		hands		=	{ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs		=	{ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet		=	{ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck		=	"Duelist's Torque",
		waist		=	"Eschan Stone",
		left_ear	=	"Malignance Earring",
		right_ear	=	"Gwati Earring",
		left_ring	=	"Weather. Ring",
		right_ring	=	"Jhakri Ring",
		back		=	{ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+6','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	-- Type F-potency from "Enfeebling potency" gear only
    sets.midcast.Enfeebling.skillmndpot = {
		range		=	"Kaja Bow",
		head		=	AF.Head,
		body		=	AF.Body,
		hands		=	{ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs		=	{ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet		=	{ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck		=	"Duelist's Torque",
		waist		=	"Eschan Stone",
		left_ear	=	"Malignance Earring",
		right_ear	=	"Gwati Earring",
		left_ring	=	"Weather. Ring",
		right_ring	=	"Jhakri Ring",
		back		=	{ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+6','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
    -- Enhancing yourself 
    sets.midcast.enhancing.duration = {
		head		=	{ name="Telchine Cap", augments={'Mag. Evasion+12','"Elemental Siphon"+25','Enh. Mag. eff. dur. +7',}},
		body		=	{ name="Telchine Chas.", augments={'Mag. Evasion+4','"Cure" spellcasting time -6%','Enh. Mag. eff. dur. +8',}},
		hands		=	AF.Hands,
		legs		=	{ name="Telchine Braconi", augments={'"Mag.Atk.Bns."+10','"Elemental Siphon"+35','Enh. Mag. eff. dur. +9',}},
		feet		=	EMPY.Feet,
		neck		=	{ name="Duelist's Torque", augments={'Path: A',}},
		back		=	{ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+6','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	
    -- For Potency spells like Temper and Enspells
    sets.midcast.enhancing.potency = set_combine(sets.midcast.enhancing.duration, {
		body	=	RELIC.Body,
		hands	=	RELIC.Hands,
		legs	=	AF.Legs,
		feet	=	EMPY.Feet,
		neck	=	"Incanter's Torque",
		back	=	{ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+6','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}) 

    -- This is used when casting under Composure but enhancing someone else other than yourself. 
    sets.midcast.enhancing.composure = set_combine(sets.midcast.enhancing.duration, {
        head		=	EMPY.Head,
        hands		=	AF.Hands,
        legs		=	EMPY.Legs,
        back		=	RDMCape.MACC,
    })  


    -- Phalanx
    sets.midcast.phalanx =  set_combine(sets.midcast.enhancing.duration, {
        --head		=	Taeon.Head.Phalanx,
        --body		=	Taeon.Body.Phalanx,
        --hands		=	Taeon.Hands.Phalanx,
        --legs		=	Taeon.Legs.Phalanx,
        --feet		=	Taeon.Feet.Phalanx,
    })

    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing.duration, {
		waist		=	"Siegel Sash",
    })
    sets.midcast.refresh = set_combine(sets.midcast.enhancing.duration, {
		--head		=	Amal.Head.A,
		body =	AF.Body,
		legs = 	EMPY.Legs
    })

    sets.midcast.aquaveil = set_combine(sets.midcast.refresh, {
	
	})
	
    sets.midcast["Drain"] = set_combine(sets.midcast.nuking, {
        main		=	"Rubicundity",
		head		=	"Pixie Hairpin +1",
		neck		=	"Erra Pendant",
    })
    sets.midcast["Aspir"] = sets.midcast["Drain"]
 	
    sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    
	sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
		sub			=	"Sors Shield",
		ammo		=	"Homiliary",
		head		=	{ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body		=	{ name="Vanya Robe", augments={'MP+49','"Cure" potency +7%','Enmity-5',}},
		hands		=	{ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%',}},
		legs		=	"Atrophy Tights +1",
		feet		=	{ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck		=	"Incanter's Torque",
		left_ear	=	"Mendi. Earring",
		right_ear	=	"Loquac. Earring",
		left_ring	= 	"Ephedra Ring",
		right_ring	=	"Sirona's Ring",
		back		=	"Solemnity Cape",
	})
    
	sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{
		main		=	"Chatoyant Staff",
		sub			=	"Enki Strap",
		waist		=	"Hachirin-no-Obi",
    })

	sets.midcast["Cursna"] = set_combine(sets.midcast.cure.normal, {
        
    })

    ------------
    -- Regen
    ------------	
	sets.midcast.regen = set_combine(sets.midcast.enhancing.duration, {

    })

	
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
	
end