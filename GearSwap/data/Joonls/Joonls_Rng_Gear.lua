-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Normal','DTLite','DT')
	state.RangedMode:options('Normal','Acc','Fodder','Crits')
	state.WeaponskillMode:options('Match','Normal', 'Acc')
	state.IdleMode:options('Normal', 'PDT')
	state.Weapons:options('Default','Anni','Foma','DualAnni','DualFoma','DualSavageWeapons','DualMagicWeapons', 'DualMalevolence','DualEvisceration','DualAeolian')
	
	WeaponType =  {['Fail-Not'] = "Bow",
                   ['Fomalhaut'] = "Gun",
				   ['Ataktos'] = "Gun",
				   ['Annihilator'] = "Gun",
				   ['Sparrowhawk +2'] = "Bow",
				   ['Kaja Bow'] = "Bow",
                   }

	DefaultAmmo = {
		['Bow']  = {['Default'] = "Chapuli Arrow",
					['WS'] = "Chapuli Arrow",
					['Acc'] = "Chapuli Arrow",
					['Magic'] = "Chapuli Arrow",
					['MagicAcc'] = "Chapuli Arrow",
					['Unlimited'] = "Chapuli Arrow",
					['MagicUnlimited'] ="Chapuli Arrow",
					['MagicAccUnlimited'] = "Chapuli Arrow"},
					
		['Gun']  = {['Default'] = "Chrono Bullet",
					['WS'] = "Chrono Bullet",
					['Acc'] = "Chrono Bullet",
					['Magic'] = "Orichalcum Bullet",
					['MagicAcc'] = "Orichalcum Bullet",
					['Unlimited'] = "Chrono Bullet",
					['MagicUnlimited'] = "Chrono Bullet",
					['MagicAccUnlimited'] ="Animikii Bullet"},
					
		['Crossbow'] = {['Default'] = "Eminent Bolt",
						['WS'] = "Eminent Bolt",
						['Acc'] = "Eminent Bolt",
						['Magic'] = "Eminent Bolt",
						['MagicAcc'] = "Eminent Bolt",
						['Unlimited'] = "Hauksbok Bolt",
						['MagicUnlimited'] = "Hauksbok Bolt",
						['MagicAccUnlimited'] ="Hauksbok Bolt"}
	}
		
	    -- Additional local binds
    send_command('bind !` input /ra <t>')
	send_command('bind !backspace input /ja "Bounty Shot" <t>')
	send_command('bind @f7 gs c toggle RngHelper')
	send_command('bind @` gs c cycle SkillchainMode')
	-- send_command('bind !t gs c weapons MagicWeapons;gs c update')
	-- send_command('bind ^q gs c weapons SingleWeapon;gs c update')
	
	send_command('bind ^w gs c cycle weapons')
	
	select_default_macro_book()

end

-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	
	
	-- Precast sets to enhance JAs
	sets.TreasureHunter = {
		head={ name="Herculean Helm", augments={'"Fast Cast"+2','"Drain" and "Aspir" potency +1','"Treasure Hunter"+2','Accuracy+10 Attack+10','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
		body={ name="Herculean Vest", augments={'"Drain" and "Aspir" potency +7','"Store TP"+3','"Treasure Hunter"+2',}},
	}
	sets.precast.JA['Bounty Shot'] = set_combine(sets.TreasureHunter, {})
	sets.precast.JA['Camouflage'] = {}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +2"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +1"}
	sets.precast.JA['Double Shot'] = {back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},}


	-- Fast cast sets for spells

    sets.precast.FC = {
		head={ name="Herculean Helm", augments={'"Fast Cast"+2','"Drain" and "Aspir" potency +1','"Treasure Hunter"+2','Accuracy+10 Attack+10','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
		body={ name="Taeon Tabard", augments={'Accuracy+9','"Snapshot"+4','"Snapshot"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		neck="Baetyl Pendant",
		waist="Flume Belt",
		right_ear="Loquac. Earring",
		left_ring="Prolix Ring",
		right_ring="Weather. Ring",
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket"})


	-- Ranged sets (snapshot)
	
	-- (10% Snapshot, 5% Rapid from Merits)
    sets.precast.RA = {
            head={ name="Taeon Chapeau", augments={'Accuracy+11','"Snapshot"+4','"Snapshot"+4',}},
		body={ name="Taeon Tabard", augments={'Accuracy+9','"Snapshot"+4','"Snapshot"+4',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
		feet="Meg. Jam. +2",
		neck={ name="Scout's Gorget", augments={'Path: A',}},
		waist="Impulse Belt",
		left_ring="Defending Ring",
		right_ring="Crepuscular Ring",
		back={ name="Belenus's Cape", augments={'"Snapshot"+10',}},
	} --69

    sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
        head="Arcadian Beret +3", --0/10
        body="Amini Caban +1",
        neck="Scout's Gorget", --3/0
        waist="Impulse Belt", --3/0
	}) --43/39

    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
        feet="Arcadian Socks +3", --0/10
	}) --38/49


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head="Orion Beret +3",
		body={ name="Arc. Jerkin +3", augments={'Enhances "Snapshot" effect',}},
		hands="Meg. Gloves +2",
		legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck={ name="Scout's Gorget", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Dingir Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	}
		
    sets.precast.WS.Acc = {
        head="Orion Beret +3",
		body={ name="Arc. Jerkin +3", augments={'Enhances "Snapshot" effect',}},
		hands="Meg. Gloves +2",
		legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck={ name="Scout's Gorget", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Dingir Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	}

    sets.precast.WS['Wildfire'] = {    
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear="Ishvara Earring",
		right_ear="Friomisi Earring",
		left_ring="Regal Ring",
		right_ring="Dingir Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	}

    sets.precast.WS['Wildfire'].Acc = {    
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear="Ishvara Earring",
		right_ear="Friomisi Earring",
		left_ring="Regal Ring",
		right_ring="Dingir Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	}
		
    sets.precast.WS['Aeolian Edge'] = {
		ammo="Orichalcum Bullet",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Regal Ring",
		right_ring="Dingir Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	}
		
    sets.precast.WS['Trueflight'] = {    
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Weather. Ring",
		right_ring="Dingir Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	}

    sets.precast.WS['Trueflight'].Acc = {    
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Weather. Ring",
		right_ring="Dingir Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	}
	
	sets.precast.WS['Savage Blade'] = {    
		ammo="Hauksbok Arrow",
		head="Orion Beret +3",
		body={ name="Arc. Jerkin +3", augments={'Enhances "Snapshot" effect',}},
		hands="Meg. Gloves +2",
		legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
		feet={ name="Herculean Boots", augments={'Accuracy+15','Weapon skill damage +5%','MND+10','Mag. Acc.+14',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring={ name="Beithir Ring", augments={'Path: A',}},
		right_ring="Rajas Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	}
	
	sets.precast.WS['Savage Blade'].Acc = {    
		ammo="Hauksbok Arrow",
		head="Orion Beret +3",
		body={ name="Arc. Jerkin +3", augments={'Enhances "Snapshot" effect',}},
		hands="Meg. Gloves +2",
		legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
		feet={ name="Herculean Boots", augments={'Accuracy+15','Weapon skill damage +5%','MND+10','Mag. Acc.+14',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring={ name="Beithir Ring", augments={'Path: A',}},
		right_ring="Rajas Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	}
	
	
		
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
    sets.midcast.FastRecast = {
		head={ name="Herculean Helm", augments={'"Fast Cast"+2','"Drain" and "Aspir" potency +1','"Treasure Hunter"+2','Accuracy+10 Attack+10','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
		body={ name="Taeon Tabard", augments={'Accuracy+9','"Snapshot"+4','"Snapshot"+4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		neck="Baetyl Pendant",
		waist="Flume Belt",
		right_ear="Loquac. Earring",
		left_ring="Prolix Ring",
		right_ring="Weather. Ring",
	}
		
	-- Ranged sets

    sets.midcast.RA = {
		head={ name="Arcadian Beret +3", augments={'Enhances "Recycle" effect',}},
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
		feet="Malignance Boots",
		neck={ name="Scout's Gorget", augments={'Path: A',}},
		waist="Kwahu Kachina Belt",
		left_ear="Crep. Earring",
		right_ear="Dedition Earring",
		left_ring="Crepuscular Ring",
		right_ring="Dingir ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
	
    sets.midcast.RA.Acc = {
		head={ name="Arcadian Beret +3", augments={'Enhances "Recycle" effect',}},
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
		feet="Malignance Boots",
		neck={ name="Scout's Gorget", augments={'Path: A',}},
		waist="Kwahu Kachina Belt",
		left_ear="Crep. Earring",
		right_ear="Dedition Earring",
		left_ring="Paqichikaji Ring",
		right_ring="Crepuscular Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
		
    sets.midcast.RA.Fodder = {
		head={ name="Arcadian Beret +3", augments={'Enhances "Recycle" effect',}},
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Adhemar Kecks +1",
		feet="Malignance Boots",
		neck="Scout's Gorget",
		waist="Kwahu Kachina Belt",
		left_ear="Neritic Earring",
		right_ear="Sherida Earring",
		left_ring="Paqichikaji Ring",
		right_ring="Rajas Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
	
	sets.midcast.RA.Crits = set_combine(sets.midcast.RA, {
		body="Sayadio's Kaftan",
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
		feet={ name="Arcadian Socks +3", augments={'Enhances "Stealth Shot" effect',}},
		waist="Kwahu Kachina Belt",
		right_ear="Odr Earring",
	})
		
	--These sets will overlay based on accuracy level, regardless of other options.
	sets.buff.Camouflage = {}
	sets.buff.Camouflage.Acc = {}
	sets.buff['Double Shot'] = {    
		head={ name="Arcadian Beret +3", augments={'Enhances "Recycle" effect',}},
		body={ name="Arc. Jerkin +3", augments={'Enhances "Snapshot" effect',}},
		hands="Oshosi Gloves",
		feet="Oshosi Leggings",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
	sets.buff['Double Shot'].Acc = {    
		head={ name="Arcadian Beret +3", augments={'Enhances "Recycle" effect',}},
		body={ name="Arc. Jerkin +3", augments={'Enhances "Snapshot" effect',}},
		hands="Oshosi Gloves",
		feet="Oshosi Leggings",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
	sets.buff.Barrage = {hands="Orion Bracers +2"}
	
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {}

	-- Idle sets
    sets.idle = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Carmine Cuisses +1",
		feet="Malignance Boots",
		neck="Bathy Choker +1",
		waist="Flume Belt",
		left_ear="Hearty Earring",
		right_ear="Static Earring",
		left_ring="Defending Ring",
		right_ring="Dark Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
    
    -- Defense sets
    sets.defense.PDT = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Carmine Cuisses +1",
		feet="Malignance Boots",
		neck="Bathy Choker +1",
		waist="Flume Belt",
		left_ear="Hearty Earring",
		right_ear="Static Earring",
		left_ring="Defending Ring",
		right_ring="Dark Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}

    sets.defense.MDT = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Carmine Cuisses +1",
		feet="Malignance Boots",
		neck="Bathy Choker +1",
		waist="Flume Belt",
		left_ear="Hearty Earring",
		right_ear="Static Earring",
		left_ring="Defending Ring",
		right_ring="Dark Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
		
    sets.defense.MEVA = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Carmine Cuisses +1",
		feet="Malignance Boots",
		neck="Bathy Choker +1",
		waist="Flume Belt",
		left_ear="Hearty Earring",
		right_ear="Static Earring",
		left_ring="Defending Ring",
		right_ring="Dark Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}

    sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	-- Weapons sets
	sets.weapons = {}
	sets.weapons.Default = {main="Perun +1",sub="Legion Scutum",range="Annihilator"}
	sets.weapons.Anni = {main="Perun +1",sub="Legion Scutum",range="Annihilator"}
	sets.weapons.Foma = {main="Perun +1",sub="Legion Scutum",range="Fomalhaut"}
	sets.weapons.DualAnni = {main="Perun +1",sub="Ternion Dagger +1",range="Annihilator"}
	sets.weapons.DualFoma = {main="Perun +1",sub="Ternion Dagger +1",range="Fomalhaut"}
	sets.weapons.DualSavageWeapons = {main="Naegling",sub="Ternion Dagger +1",range="Sparrowhawk +2"}
	sets.weapons.DualMagicWeapons = {main="Malevolence",sub="Tauret",range="Fomalhaut"}
	sets.weapons.DualEvisceration = {main="Tauret",sub="Ternion Dagger +1",range="Annihilator"}
	sets.weapons.DualMalevolence = {main="Malevolence",sub="Ternion Dagger +1",range="Fomalhaut"}
	sets.weapons.DualAeolian = {main="Malevolence",sub="Ternion Dagger +1",range="Anarchy +2"}
	

	--------------------------------------
	-- Engaged sets
	--------------------------------------

    -- Normal melee group
    sets.engaged = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Clotharius Torque",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear="Cessance Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back={name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	}
    
    sets.engaged.Acc = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Clotharius Torque",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear="Cessance Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back={name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	}

    sets.engaged.DTLite =  {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Clotharius Torque",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear="Cessance Earring",
		left_ring="Defending Ring",
		right_ring="Rajas Ring",
		back={name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	}
		
    sets.engaged.DT = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist="Sailfi Belt +1",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Defending Ring",
		right_ring="Dark Ring",
		back={name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	}

    sets.engaged.DW =  {
		head="Adhemar Bonnet",
		body={ name="Herculean Vest", augments={'"Snapshot"+4','DEX+6','Quadruple Attack +3','Accuracy+16 Attack+16','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+20','"Triple Atk."+3','STR+7','Attack+14',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Anu Torque",
		waist="Sailfi Belt +1",
		left_ear="Suppanomimi",
		right_ear="Sherida Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back={name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	}
		
    sets.engaged.DW.DT =  {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist="Sailfi Belt +1",
		left_ear="Suppanomimi",
		right_ear="Dedition Earring",
		left_ring="Defending Ring",
		right_ring="Dark Ring",
		back={name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	}
    
    sets.engaged.DW.Acc =  {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Clotharius Torque",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear="Cessance Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back={name="Belenus's Cape",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'NIN' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'DNC' then
		set_macro_page(1, 6)
    elseif player.sub_job == 'DRG' then
        set_macro_page(3, 6)
    else
        set_macro_page(1, 6)
    end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 4')
end
