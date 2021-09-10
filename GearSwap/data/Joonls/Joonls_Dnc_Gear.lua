-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal', 'SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal','Counter','CounterDT','DTLite','PDT','MDT')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder','Proc')
	state.IdleMode:options('Normal', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None', 'Terp', 'TerpTauret', 'Tauret', 'Gleti', 'TPBonus','PunchTime')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWMax'}

	
	gear.stp_jse_back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','System: 1 ID: 640 Val: 4',}}
		
    -- Additional local binds
    send_command('bind @` gs c step')
	send_command('bind ^!@` gs c toggle usealtstep')
	send_command('bind ^@` gs c cycle mainstep')
	send_command('bind !@` gs c cycle altstep')
	send_command('bind ^w gs c cycle weapons;')
    send_command('bind ^` input /ja "Saber Dance" <me>')
    send_command('bind !` input /ja "Fan Dance" <me>')
	send_command('bind ^\\\\ input /ja "Chocobo Jig II" <me>')
	send_command('bind !\\\\ input /ja "Spectral Jig" <me>')
	send_command('bind !backspace input /ja "Reverse Flourish" <me>')
	send_command('bind ^backspace input /ja "No Foot Rise" <me>')
	send_command('bind %~` gs c cycle SkillchainMode')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
			head={ name="Herculean Helm", augments={'"Fast Cast"+2','"Drain" and "Aspir" potency +1','"Treasure Hunter"+2','Accuracy+10 Attack+10','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
			body={ name="Herculean Vest", augments={'"Drain" and "Aspir" potency +7','"Store TP"+3','"Treasure Hunter"+2',}},
		})
	
	
    -- Extra Melee sets.  Apply these on top of melee sets.
	sets.Suppa = {ear1="Suppanomimi", ear2="Sherida Earring"}
	sets.DWMax = {body="Adhemar Jacket +1"}
	
	-- Weapons sets
	sets.weapons = {}
	sets.weapons.None = {}
	sets.weapons.Terp = {main="Terpsichore", sub="Gleti's Knife"}
	sets.weapons.TerpTauret = {main="Terpsichore", sub="Tauret"}
	sets.weapons.Tauret = {main="Tauret", sub="Gleti's Knife"}
	sets.weapons.Gleti = {main="Gleti's Knife", sub="Ternion Dagger +1"}
	sets.weapons.TPBonus = {main="Terpsichore", sub="Fusetto +2"}
	sets.weapons.PunchTime = {main="Karambit"}
	
    -- Precast Sets
    
    -- Precast sets to enhance JAs

    sets.precast.JA['No Foot Rise'] = {} --body="Horos Casaque +1"

    sets.precast.JA['Trance'] = {} --head="Horos Tiara +1"
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {    
		ammo="Yamarang",
		head={ name="Anwig Salade", augments={'CHR+4','"Waltz" ability delay -2','STR+4','Weapon Skill Acc.+15',}},
		body="Maxixi Casaque +2",
		hands={ name="Herculean Gloves", augments={'"Waltz" potency +10%','Attack+3','Phalanx +2','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		legs="Meg. Chausses +2",
		feet="Maxixi Shoes +1",
		neck="Twilight Torque",
		waist="Flume Belt",
		left_ear="Handler's Earring +1",
		right_ear="Handler's Earring",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring",
		back={ name="Senuna's Mantle", augments={'DEX+10','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
		
	sets.Self_Waltz = sets.precast.Waltz
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Samba = {head="Maxixi Tiara +1", back=gear.stp_jse_back} --head="Maxixi Tiara"

    sets.precast.Jig = {legs="Horos Tights", feet="Maxixi Shoes +1"} --legs="Horos Tights", feet="Maxixi Toe Shoes"

    sets.precast.Step = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Maxixi Bangles +3",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Clotharius Torque",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Mache Earring",
		left_ring="Regal Ring",
		right_ring="Rajas Ring",
		back={ name="Senuna's Mantle", augments={'DEX+10','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
		
    sets.Enmity = {}
		
    sets.precast.JA.Provoke = sets.Enmity

    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Maxixi Bangles +3",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Clotharius Torque",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Mache Earring",
		left_ring="Regal Ring",
		right_ring="Rajas Ring",
		back={ name="Senuna's Mantle", augments={'DEX+10','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
		
    sets.precast.Flourish1['Animated Flourish'] = sets.Enmity
		
    sets.precast.Flourish1['Desperate Flourish'] = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Maxixi Bangles +3",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Clotharius Torque",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Mache Earring",
		left_ring="Regal Ring",
		right_ring="Rajas Ring",
		back=gear.wsd_jse_back
	}

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {back="Toetapper Mantle", hands="Macu. Bangles +1"}

    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {body="Macu. Casaque +1"} --body="Charis Casaque +2"
    sets.precast.Flourish3['Climactic Flourish'] = {head="Maculele Tiara +1"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		ammo="Impatiens",
		head={ name="Herculean Helm", augments={'"Fast Cast"+2','"Drain" and "Aspir" potency +1','"Treasure Hunter"+2','Accuracy+10 Attack+10','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
		body="Meg. Cuirie +2",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Meg. Chausses +2",
		feet="Malignance boots",
		neck="Voltsurge Torque",
		waist="Flume Belt",
		left_ear="Loquac. Earring",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",
		right_ring="Weather. Ring",
		back=gear.wsd_jse_back
	}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Ginsen",
		head={ name="Herculean Helm", augments={'Rng.Acc.+22','Pet: "Regen"+2','Weapon skill damage +7%','Accuracy+9 Attack+9','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		body="Meg. Cuirie +2",
		hands="Maxixi Bangles +3",
		legs={ name="Herculean Trousers", augments={'"Dbl.Atk."+2','CHR+9','Weapon skill damage +5%','Accuracy+2 Attack+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Beithir Ring",
		back={ name="Senuna's Mantle", augments={'DEX+10','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	sets.precast.WS.SomeAcc = {
		ammo="Ginsen",
		head={ name="Herculean Helm", augments={'Rng.Acc.+22','Pet: "Regen"+2','Weapon skill damage +7%','Accuracy+9 Attack+9','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		body="Meg. Cuirie +2",
		hands="Maxixi Bangles +3",
		legs={ name="Herculean Trousers", augments={'"Dbl.Atk."+2','CHR+9','Weapon skill damage +5%','Accuracy+2 Attack+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring="Rajas Ring",
		back={ name="Senuna's Mantle", augments={'DEX+10','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.Acc = set_combine(sets.precast.WS, {})
	
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Proc = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Rudra's Storm"] = {
		ammo="Charis Feather",
		head={ name="Herculean Helm", augments={'Rng.Acc.+22','Pet: "Regen"+2','Weapon skill damage +7%','Accuracy+9 Attack+9','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		body="Meg. Cuirie +2",
		hands="Maxixi Bangles +3",
		legs={ name="Herculean Trousers", augments={'"Dbl.Atk."+2','CHR+9','Weapon skill damage +5%','Accuracy+2 Attack+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck={ name="Etoile Gorget", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Odr Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Regal Ring",
		right_ring={ name="Beithir Ring", augments={'Path: A',}},
		back={ name="Senuna's Mantle", augments={'DEX+10','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
    sets.precast.WS["Rudra's Storm"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})
	
    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {})
    sets.precast.WS["Shark Bite"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS["Shark Bite"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {})
	
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Evisceration'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})
	
    sets.precast.WS['Pyrrhic Kleos'] = {
		ammo="Charis Feather",
		head={ name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+20','"Triple Atk."+3','STR+7','Attack+14',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Epona's Ring",
		back={ name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
    sets.precast.WS['Pyrrhic Kleos'].SomeAcc = set_combine(sets.precast.WS['Pyrrhic Kleos'], {})
    sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS['Pyrrhic Kleos'], {})
	sets.precast.WS['Pyrrhic Kleos'].FullAcc = set_combine(sets.precast.WS['Pyrrhic Kleos'], {})
	sets.precast.WS['Pyrrhic Kleos'].Fodder = set_combine(sets.precast.WS['Pyrrhic Kleos'], {})
	
	sets.precast.WS['Evisceration'] = {
		ammo="Charis Feather",
		head={ name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}},
		body="Meg. Cuirie +2",
		hands="Mummu Wrists +2",
		legs={ name="Gleti's Breeches", augments={'Path: A',}},
		feet="Mummu Gamash. +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Mummu Ring",
		back={ name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
    sets.precast.WS['Evisceration'].SomeAcc = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS['Evisceration'], {})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})

    sets.precast.WS['Aeolian Edge'] = {
		ammo="Ghastly Tathlum +1",
		head={ name="Herculean Helm", augments={'Rng.Acc.+22','Pet: "Regen"+2','Weapon skill damage +7%','Accuracy+9 Attack+9','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		body={ name="Herculean Vest", augments={'"Snapshot"+4','DEX+6','Quadruple Attack +3','Accuracy+16 Attack+16','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck="Baetyl Pendant",
		waist="Chaac Belt",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Metamor. Ring +1",
		right_ring="Acumen Ring",
		back={ name="Senuna's Mantle", augments={'DEX+10','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)
	
	sets.precast.WS['Asuran Fists'] = {
		ammo="Ginsen",
		head={ name="Herculean Helm", augments={'Rng.Acc.+22','Pet: "Regen"+2','Weapon skill damage +7%','Accuracy+9 Attack+9','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		body="Nyame Mail",
		hands="Maxixi Bangles +3",
		legs={ name="Herculean Trousers", augments={'"Dbl.Atk."+2','CHR+9','Weapon skill damage +5%','Accuracy+2 Attack+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear="Ishvara Earring",
		left_ring={ name="Beithir Ring", augments={'Path: A',}},
		right_ring="Regal Ring",
		back={ name="Senuna's Mantle", augments={'DEX+10','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Sherida Earring"}
	sets.AccMaxTP = {ear1="Mache Earring",ear2="Sherida Earring"}
	
    sets.Skillchain = {} --hands="Charis Bangles +2"
    
    
    -- Midcast Sets
    
    sets.midcast.FastRecast = {}
        
    -- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    sets.ExtraRegen = {}
    

    -- Idle sets

    sets.idle = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Tandava Crackows",
		neck="Bathy Choker +1",
		waist="Flume Belt",
		left_ear="Static Earring",
		right_ear="Thureous Earring",
		left_ring="Defending Ring",
		right_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -6%',}},
		back={ name="Senuna's Mantle", augments={'DEX+10','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
		
    sets.idle.Sphere = set_combine(sets.idle, {})
    
    -- Defense sets

    sets.defense.PDT = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist="Flume Belt",
		left_ear="Static Earring",
		right_ear="Thureous Earring",
		left_ring="Defending Ring",
		right_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -6%',}},
		back={ name="Senuna's Mantle", augments={'DEX+10','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
    sets.defense.MDT = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist="Flume Belt",
		left_ear="Static Earring",
		right_ear="Thureous Earring",
		left_ring="Defending Ring",
		right_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -6%',}},
		back={ name="Senuna's Mantle", augments={'DEX+10','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
		
	sets.defense.MEVA = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist="Flume Belt",
		left_ear="Static Earring",
		right_ear="Thureous Earring",
		left_ring="Defending Ring",
		right_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -6%',}},
		back={ name="Senuna's Mantle", augments={'DEX+10','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
    sets.Kiting = {feet="Tandava Crackows"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
	sets.engaged = {
		ammo="Yamarang",
		head={ name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+20','"Triple Atk."+3','STR+7','Attack+14',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Anu Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Epona's Ring",
		right_ring="Rajas Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
	}
	
	sets.engaged.AM = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Malignance Boots",
		neck="Anu Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Crep. Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
	}
		
    sets.engaged.DTLite = {
	    ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance boots",
		neck={ name="Etoile Gorget", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Crep. Earring",
		left_ring="Defending Ring",
		right_ring="Epona's Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
	}
	
	sets.engaged.DTLite.AM = set_combine(sets.engaged.DTLite, {})
	
	sets.engaged.Counter = {
	    ammo="Yamarang",
		head={ name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Horos Bangles +3", augments={'Enhances "Fan Dance" effect',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Dedition Earring",
		left_ring="Defending Ring",
		right_ring="Epona's Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
	}
	
	sets.engaged.Counter.AM = set_combine(sets.engaged.Counter, {})
	
	sets.engaged.CounterDT = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands={ name="Horos Bangles +3", augments={'Enhances "Fan Dance" effect',}},
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Dedition Earring",
		left_ring="Defending Ring",
		right_ring="Epona's Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
	}
	
	sets.engaged.CounterDT.AM = set_combine(sets.engaged.CounterDT, {})
		
    sets.engaged.SomeAcc = {
	    ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance gloves",
		legs="Samnuha tights",
		feet="Malignance boots",
		neck="Anu Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Crep. Earring",
		left_ring="Epona's Ring",
		right_ring="Rajas Ring",
		back=gear.stp_jse_back,
	}
    
	sets.engaged.Acc = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Malignance Boots",
		neck="Anu Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Crep. Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back={ name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
	}
		
    sets.engaged.FullAcc = {
	    ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",
		right_ring="Hetairoi Ring",
		back=gear.stp_jse_back,
	}

    sets.engaged.Fodder = {
	    ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",
		right_ring="Hetairoi Ring",
		back=gear.stp_jse_back,
	}

    sets.engaged.PDT = {
	    ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",
		right_ring="Hetairoi Ring",
		back=gear.stp_jse_back,
	}

    sets.engaged.SomeAcc.PDT = {
	    ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",
		right_ring="Hetairoi Ring",
		back=gear.stp_jse_back,
	}
		
    sets.engaged.Acc.PDT = {
	    ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",
		right_ring="Hetairoi Ring",
		back=gear.stp_jse_back,
	}

    sets.engaged.FullAcc.PDT = {
	    ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",
		right_ring="Hetairoi Ring",
		back=gear.stp_jse_back,
	}
		
    sets.engaged.Fodder.PDT = {
	    ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",
		right_ring="Hetairoi Ring",
		back=gear.stp_jse_back,
	}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Saber Dance'] = {} --legs="Horos Tights"
    sets.buff['Climactic Flourish'] = {ammo="Charis Feather", body="Meg. Cuirie +2", head="Maculele Tiara +1"} --head="Charis Tiara +2"
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(3, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 2)
    elseif player.sub_job == 'SAM' then
        set_macro_page(3, 2)
    elseif player.sub_job == 'THF' then
        set_macro_page(3, 2)
    else
        set_macro_page(3, 2)
    end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 021') --Catchall just in case something's weird.
end