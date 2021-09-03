-- Setup vars that are user-dependent.
function user_job_setup()
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal','DTLite','PDT','Reraise')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder','Proc')
    state.RangedMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT','PDTReraise')
	state.MagicalDefenseMode:options('MDT','MDTReraise')
	state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Normal', 'Reraise')
	state.Weapons:options('Dojikiri', 'DojiWithBow', 'SO', 'SOWithBow', 'ProcWeapon', 'Bow')

	gear.ws_jse_back = {name="Smertrios's Mantle",augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	gear.stp_jse_back = {name="Smertrios's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind !backspace input /ja "Third Eye" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !@^` gs c cycle Stance')
	send_command('bind ^w gs c cycle Weapons')
	send_command('bind !t gs c set skipprocweapons false;gs c weapons ProcWeapon;gs c set WeaponskillMode Proc;gs c update')
	send_command('bind ^r gs c set skipprocweapons true;gs c weapons Default;gs c set WeaponskillMode Normal;gs c update')
	send_command('bind ^q gs c weapons Bow;gs c update')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Wakido Kabuto +3",hands="Sakonji Kote +1",back=gear.ws_jse_back}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +3"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +1"}
	sets.precast.JA['Sekkanoki'] = {hands="Kasuga Kote +1"}
	sets.precast.JA['Sengikori'] = {feet="Kas. Sune-Ate +1"}
	
    sets.precast.Step = {}
    sets.precast.JA['Violent Flourish'] = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.precast.FC = {neck="Voltsurge Torque",ear2="Loquac. Earring",hands="Leyline Gloves",ring2="Prolix Ring"}
	   
    -- Ranged snapshot gear
    sets.precast.RA = {
	}
	   
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body={ name="Valorous Mail", augments={'Accuracy+3 Attack+3','Weapon skill damage +3%','STR+12',}},
		hands={ name="Valorous Mitts", augments={'Accuracy+21 Attack+21','Weapon skill damage +4%','INT+4',}},
		legs="Wakido Haidate +3",
		feet={ name="Valorous Greaves", augments={'Accuracy+9','Weapon skill damage +3%','STR+12','Attack+4',}},
		neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring={ name="Beithir Ring", augments={'Path: A',}},
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
    sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
    sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})
	
	sets.precast.WS.Proc = set_combine(sets.precast.WS, {})
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Fudo'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Fudo'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Fudo'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Shoha'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Shoha'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Shoha'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Rana'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Rana'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Rana'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Kasha'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Kasha'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Kasha'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Kasha'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Gekko'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Gekko'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Gekko'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Gekko'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Yukikaze'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Yukikaze'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Yukikaze'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Yukikaze'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Nyame Gauntlets",
		legs="Mpaca's Hose",
		feet="Flam. Gambieras +2",
		neck="Fotia Gorget",
		waist="Eschan Stone",
		left_ear="Hermetic Earring",
		right_ear="Gwati Earring",
		left_ring="Stikini Ring",
		right_ring="Flamma Ring",

	})
		
    sets.precast.WS['Tachi: Hobaku'] = set_combine(sets.precast.WS, {})
		
    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {
		body="Sacro breastplate",
		hands="Nyame Gauntlets",
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Fotia Belt",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Acumen Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	})
	
	sets.precast.WS['Tachi: Hobaku'] = set_combine(sets.precast.WS, sets.precast.WS['Tachi: Jinpu'])
	sets.precast.WS['Tachi: Goten'] = set_combine(sets.precast.WS, sets.precast.WS['Tachi: Jinpu'])
	sets.precast.WS['Tachi: Koki'] = set_combine(sets.precast.WS, sets.precast.WS['Tachi: Jinpu'])
	sets.precast.WS['Tachi: Kagero'] = set_combine(sets.precast.WS, sets.precast.WS['Tachi: Jinpu'])
	

    sets.precast.WS['Apex Arrow'] = set_combine(sets.precast.WS, {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sam. Nodowa +1",
		waist="Fotia Belt",
		neck="Fotia gorget",
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Crepuscular Ring",
		right_ring="Paqichikaji Ring",
	})
		
	
    sets.precast.WS['Apex Arrow'].SomeAcc = set_combine(sets.precast.WS['Apex Arrow'], {})
    sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {})
    sets.precast.WS['Apex Arrow'].FullAcc = set_combine(sets.precast.WS['Apex Arrow'], {})
    sets.precast.WS['Apex Arrow'].Fodder = set_combine(sets.precast.WS['Apex Arrow'], {})
	
	sets.precast.WS['Empyreal Arrow'] = set_combine(sets.precast.WS['Apex Arrow'], {})
	sets.precast.WS['Empyreal Arrow'].SomeAcc = set_combine(sets.precast.WS['Empyreal Arrow'], {})
    sets.precast.WS['Empyreal Arrow'].Acc = set_combine(sets.precast.WS['Empyreal Arrow'], {})
    sets.precast.WS['Empyreal Arrow'].FullAcc = set_combine(sets.precast.WS['Empyreal Arrow'], {})
    sets.precast.WS['Empyreal Arrow'].Fodder = set_combine(sets.precast.WS['Empyreal Arrow'], {})
	
	sets.precast.WS['Impulse Drive'] = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body={ name="Valorous Mail", augments={'Accuracy+3 Attack+3','Weapon skill damage +3%','STR+12',}},
		hands={ name="Valorous Mitts", augments={'Accuracy+21 Attack+21','Weapon skill damage +4%','INT+4',}},
		legs="Wakido Haidate +3",
		feet={ name="Valorous Greaves", augments={'Accuracy+9','Weapon skill damage +3%','STR+12','Attack+4',}},
		neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring={ name="Beithir Ring", augments={'Path: A',}},
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Thrud Earring", ear2="Lugra Earring +1",}
	sets.AccMaxTP = {ear1="Mache Earring", ear2="Telos Earring"}
	sets.AccDayMaxTPWSEars = {ear1="Mache Earring", ear2="Telos Earring"}
	sets.DayMaxTPWSEars = {ear1="Thrud Earring", ear2="Brutal Earring",}
	sets.AccDayWSEars = {ear1="Mache Earring", ear2="Telos Earring"}
	sets.DayWSEars = {ear1="Thrud Earring", ear2="Moonshade Earring",}
	
    -- Midcast Sets
    sets.midcast.FastRecast = {}
		
    -- Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
	
		
    -- Ranged gear
    sets.midcast.RA = {    
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Crep. Earring",
		right_ear="Cessance Earring",
		left_ring="Crepuscular Ring",
		right_ring="Paqichikaji Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {})

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	
	sets.Kiting = {feet="Danzo Sune-ate"}

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
	
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		head="Wh. Rarab Cap +1",
		waist="Chaac Belt",
		feet={ name="Valorous Greaves", augments={'Attack+6','"Mag.Atk.Bns."+21','"Treasure Hunter"+2','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
	})
	sets.Skillchain = {}
	
    sets.idle = {
		ammo="Staunch Tathlum +1",
        head=gear.valorous_wsd_head,
		neck="Twilight Torque",
        body="Hiza. Haramaki +2",
		hands="Sakonji Kote +1",
		ring1="Defending Ring",
		ring2="Dark Ring",
        back="Moonbeam Cape",
		waist="Flume Belt",
		legs="Flamma Dirs +2",
		feet="Flam. Gambieras +2",
	}
		
    sets.idle.Reraise = set_combine(sets.idle, sets.Reraise)

    sets.idle.Weak = {
		ammo="Staunch Tathlum +1",
        head=gear.valorous_wsd_head,
		neck="Twilight Torque",
        body="Hiza. Haramaki +2",
		hands="Sakonji Kote +1",
		ring1="Defending Ring",
		ring2="Dark Ring",
        back="Moonbeam Cape",
		waist="Flume Belt",
		legs="Flamma Dirs +2",
		feet="Flam. Gambieras +2",
	}
		
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
	
	sets.DayIdle = {}
	sets.NightIdle = {}
    
    -- Defense sets
    sets.defense.PDT = {
		neck="Twilight Torque",
		ring1="Defending Ring",
		ring2="Dark Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
		waist="Flume Belt"
	}

    sets.defense.PDTReraise = set_combine(sets.defense.PDT, sets.Reraise)
		
    sets.defense.MDT = {
		neck="Twilight Torque",
		ring1="Defending Ring",
		ring2="Dark Ring",
        back="Moonbeam Cape",
		waist="Flume Belt"
	}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, sets.Reraise)
	
    sets.defense.MEVA = {
		neck="Twilight Torque",
		ring1="Defending Ring",
		ring2="Dark Ring",
        back="Moonbeam Cape",
		waist="Flume Belt"
	}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {    
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Mpaca's Doublet",
		hands="Wakido Kote +3",
		legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
		feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
		neck="Sam. Nodowa +1",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Crep. Earring",
		left_ring="Flamma Ring",
		right_ring="Petrov Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
    sets.engaged.SomeAcc = set_combine(sets.engaged, {})
	
    sets.engaged.Acc = set_combine(sets.engaged, {})
	
    sets.engaged.FullAcc = set_combine(sets.engaged, {})
	
    sets.engaged.Fodder = set_combine(sets.engaged, {})
	
    sets.engaged.PDT = set_combine(sets.engaged, {})
	
    sets.engaged.SomeAcc.PDT = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.PDT = set_combine(sets.engaged, {})
	
    sets.engaged.FullAcc.PDT = set_combine(sets.engaged, {})
	
    sets.engaged.Fodder.PDT = set_combine(sets.engaged, {})
	
	sets.engaged.DTLite = set_combine(sets.engaged, {
		body="Mpaca's Doublet",
		legs="Mpaca's Hose",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		left_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	})
	
	sets.engaged.SB = set_combine(sets.engaged, {
		body="Sacro breastplate",
		legs="Mpaca's Hose",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
	})
	
    sets.engaged.SomeAcc.DTLite = set_combine(sets.engaged, {})
	
    sets.engaged.Acc.DTLite = set_combine(sets.engaged, {})
	
    sets.engaged.FullAcc.DTLite = set_combine(sets.engaged, {})
	
    sets.engaged.Fodder.DTLite = set_combine(sets.engaged, {})
	
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)		
    sets.engaged.SomeAcc.Reraise = set_combine(sets.engaged.SomeAcc, sets.Reraise)		
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)		
    sets.engaged.FullAcc.Reraise = set_combine(sets.engaged.FullAcc, sets.Reraise)		
    sets.engaged.Fodder.Reraise = set_combine(sets.engaged.Fodder, sets.Reraise)		
        
    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
    -- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
--[[Right now Adoulin sets are the same as non-Adoulin.
	sets.engaged.Adoulin = set_combine(sets.engaged, {})
	
    sets.engaged.Adoulin.SomeAcc = set_combine(sets.engaged, {})
	
	sets.engaged.Adoulin.Acc = set_combine(sets.engaged, {})
	
    sets.engaged.Adoulin.FullAcc = set_combine(sets.engaged, {})
	
    sets.engaged.Adoulin.Fodder = set_combine(sets.engaged, {})
	
    sets.engaged.Adoulin.PDT = set_combine(sets.engaged, {})
	
    sets.engaged.Adoulin.SomeAcc.PDT = set_combine(sets.engaged, {})
	
	sets.engaged.Adoulin.Acc.PDT = set_combine(sets.engaged, {})
	
    sets.engaged.Adoulin.FullAcc.PDT = set_combine(sets.engaged, {})
	
    sets.engaged.Adoulin.Fodder.PDT = set_combine(sets.engaged, {})
			
	sets.engaged.Adoulin.DTLite = sets.engaged.DTLite
    sets.engaged.Adoulin.SomeAcc.DTLite = sets.engaged.SomeAcc.DTLite
    sets.engaged.Adoulin.Acc.DTLite = sets.engaged.Acc.DTLite
    sets.engaged.Adoulin.FullAcc.DTLite = sets.engaged.FullAcc.DTLite
    sets.engaged.Adoulin.Fodder.DTLite = sets.engaged.Fodder.DTLite
    sets.engaged.Adoulin.Reraise = set_combine(sets.engaged.Adoulin, sets.Reraise)		
    sets.engaged.Adoulin.SomeAcc.Reraise = set_combine(sets.engaged.Adoulin.SomeAcc, sets.Reraise)		
    sets.engaged.Adoulin.Acc.Reraise = set_combine(sets.engaged.Adoulin.Acc, sets.Reraise)		
    sets.engaged.Adoulin.FullAcc.Reraise = set_combine(sets.engaged.Adoulin.FullAcc, sets.Reraise)		
    sets.engaged.Adoulin.Fodder.Reraise = set_combine(sets.engaged.Adoulin.Fodder, sets.Reraise)
]]--Right now Adoulin sets are the same as non-Adoulin.

	-- Weapons sets
	sets.weapons.Dojikiri = {main="Dojikiri Yasutsuna", sub="Utu Grip"}
	sets.weapons.DojiWithBow = {main="Dojikiri Yasutsuna", sub="Utu Grip", range="Kaja Bow", ammo="Chapuli Arrow"}
	sets.weapons.SO = {main="Shining One", sub="Utu Grip"}
	sets.weapons.SOWithBow = {main="Shining One", sub="Utu Grip", range="Kaja Bow", ammo="Chapuli Arrow"}
	sets.weapons.ProcWeapon = {main="Norifusa +1", sub="Utu Grip"}
	sets.weapons.Bow = {main="Norifusa +1", sub="Utu Grip", range="Kaja Bow", ammo="Chapuli Arrow"}
	
	-- Buff sets
	sets.Cure_Received = {legs="Flamma Dirs +2"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Vim Torque +1"}
	sets.buff.Hasso = {hands="Wakido Kote +3"}
	sets.buff['Third Eye'] = {} --legs="Sakonji Haidate +3"
    sets.buff.Sekkanoki = {hands="Kasuga Kote +1"}
    sets.buff.Sengikori = {feet="Kas. Sune-Ate +1"}
    sets.buff['Meikyo Shisui'] = {feet="Sak. Sune-Ate +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(3, 12)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'NIN' then
        set_macro_page(10, 12)
    elseif player.sub_job == 'THF' then
        set_macro_page(2, 12)
    else
        set_macro_page(1, 12)
    end
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()
			
				if spell_recasts[980] < spell_latency and not have_trust("Yoran-Oran") then
					windower.send_command('input /ma "Yoran-Oran (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
					windower.send_command('input /ma "Selh\'teus" <me>')
					tickdelay = os.clock() + 3
					return true
				else
					return false
				end
			end
		end
	end
	return false
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 019') --Catchall just in case something's weird.
end