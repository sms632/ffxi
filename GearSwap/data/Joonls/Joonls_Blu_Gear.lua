function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc','FullAcc','Fodder')
	state.HybridMode:options('Normal','DT','Counter','Crits')
    state.WeaponskillMode:options('Match','Normal','Acc','FullAcc','Fodder')
    state.CastingMode:options('Normal','Resistant','Fodder','Proc')
    state.IdleMode:options('Normal','Sphere','PDT','DTHippo')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('TizTP','Tiz','None','MeleeClubs','MagicWeapons','HybridWeapons')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','MP','SuppaBrutal','DWEarrings','DWMax'}

	-- Additional local binds
	send_command('bind ^` input /ja "Chain Affinity" <me>')
	send_command('bind @` input /ja "Efflux" <me>')
	send_command('bind !` input /ja "Burst Affinity" <me>')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	send_command('bind ^backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Mighty Guard" <me>')
	send_command('bind !backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Carcharian Verve" <me>')
	send_command('bind @backspace input /ja "Convergence" <me>')
	send_command('bind @f10 gs c toggle LearningMode')
	send_command('bind ^@!` gs c cycle MagicBurstMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !@^f7 gs c toggle AutoWSMode')
	send_command('bind ^w gs c cycle Weapons')
	send_command('bind !t gs c weapons None;gs c update')
	send_command('bind @q gs c weapons MaccWeapons;gs c update')
	send_command('bind ^q gs c weapons TizTP;gs c update')
	send_command('bind !q gs c weapons HybridWeapons;gs c update')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	sets.buff['Burst Affinity'] = {feet="Hashishin Basmak"}
	sets.buff['Chain Affinity'] = {}
	sets.buff.Convergence = {}
	sets.buff.Diffusion = {feet="Luhlaza Charuqs"}
	sets.buff.Enchainment = {}
	sets.buff.Efflux = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	sets.HPDown = {}

	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {}


	-- Waltz set (chr and vit)
    sets.precast.Waltz = {}
	
	sets.Self_Waltz = {body="Passion Jacket"}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {    
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Malignance Boots",
		neck="Clotharius Torque",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Mache Earring",
		right_ear="Cessance Earring",
		left_ring="Kishar Ring",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.precast.Flourish1 = {    
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Malignance Boots",
		neck="Clotharius Torque",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Mache Earring",
		right_ear="Cessance Earring",
		left_ring="Kishar Ring",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	-- Fast cast sets for spells

	sets.precast.FC = {    
		ammo="Sapience Orb",
		head={ name="Herculean Helm", augments={'"Fast Cast"+2','"Drain" and "Aspir" potency +1','"Treasure Hunter"+2','Accuracy+10 Attack+10','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
		body="Malignance Tabard",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Aya. Cosciales +2",
		feet="Malignance boots",
		neck="Baetyl Pendant",
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket"})

	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {})


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Ginsen",
		head={ name="Herculean Helm", augments={'Rng.Acc.+22','Pet: "Regen"+2','Weapon skill damage +7%','Accuracy+9 Attack+9','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		body="Assim. Jubbah +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Herculean Trousers", augments={'"Dbl.Atk."+2','CHR+9','Weapon skill damage +5%','Accuracy+2 Attack+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Rajas Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}

	sets.precast.WS.Acc = {
		ammo="Ginsen",
		head={ name="Herculean Helm", augments={'Rng.Acc.+22','Pet: "Regen"+2','Weapon skill damage +7%','Accuracy+9 Attack+9','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		body="Assim. Jubbah +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Herculean Trousers", augments={'"Dbl.Atk."+2','CHR+9','Weapon skill damage +5%','Accuracy+2 Attack+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Beithir Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}

	sets.precast.WS.FullAcc = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'"Dbl.Atk."+2','CHR+9','Weapon skill damage +5%','Accuracy+2 Attack+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		feet="Malignance Boots",
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Mache Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Beithir Ring",
		right_ring="Rajas Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}

	sets.precast.WS.DT = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'"Dbl.Atk."+2','CHR+9','Weapon skill damage +5%','Accuracy+2 Attack+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		feet="Malignance Boots",
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Mache Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Defending Ring",
		right_ring="Rajas Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}

	sets.precast.WS.Fodder = {
		ammo="Ginsen",
		head={ name="Herculean Helm", augments={'Rng.Acc.+22','Pet: "Regen"+2','Weapon skill damage +7%','Accuracy+9 Attack+9','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		body="Assim. Jubbah +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Herculean Trousers", augments={'"Dbl.Atk."+2','CHR+9','Weapon skill damage +5%','Accuracy+2 Attack+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Beithir Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {head="Jhakri Coronal +2",body="Jhakri Robe +2",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {head="Jhakri Coronal +2",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"})
	sets.precast.WS['Requiescat'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Requiescat'].DT = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS['Requiescat'], {})

	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {head="Jhakri Coronal +2",body="Jhakri Robe +2",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"})
	sets.precast.WS['Realmrazer'].Acc = set_combine(sets.precast.WS.Acc, {head="Jhakri Coronal +2",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"})
	sets.precast.WS['Realmrazer'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Realmrazer'].DT = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS['Realmrazer'].Fodder = set_combine(sets.precast.WS['Realmrazer'], {})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
	    ammo="Ginsen",
		head={ name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}},
		body="Assim. Jubbah +2",
		hands="Jhakri Cuffs +2",
		legs="Gleti's Breeches",
		feet="Thereoid Greaves",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Rajas Ring",
		right_ring={ name="Beithir Ring", augments={'Path: A',}},
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+6','Crit.hit rate+10','System: 1 ID: 640 Val: 4',}},
	})
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {
	    ammo="Ginsen",
		head={ name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}},
		body="Assim. Jubbah +2",
		hands="Jhakri Cuffs +2",
		legs="Gleti's Breeches",
		feet="Thereoid Greaves",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Rajas Ring",
		right_ring={ name="Beithir Ring", augments={'Path: A',}},
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+6','Crit.hit rate+10','System: 1 ID: 640 Val: 4',}},
	})
	sets.precast.WS['Chant du Cygne'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Chant du Cygne'].DT = set_combine(sets.precast.WS.DT, {
	    ammo="Ginsen",
		head={ name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}},
		body="Assim. Jubbah +2",
		hands="Jhakri Cuffs +2",
		legs="Gleti's Breeches",
		feet="Thereoid Greaves",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odr Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Rajas Ring",
		right_ring={ name="Beithir Ring", augments={'Path: A',}},
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+6','Crit.hit rate+10','System: 1 ID: 640 Val: 4',}},
	})
	sets.precast.WS['Chant du Cygne'].Fodder = set_combine(sets.precast.WS['Chant du Cygne'], {})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		ammo="Ginsen",
		head={ name="Herculean Helm", augments={'Rng.Acc.+22','Pet: "Regen"+2','Weapon skill damage +7%','Accuracy+9 Attack+9','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		body="Assim. Jubbah +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Herculean Trousers", augments={'"Dbl.Atk."+2','CHR+9','Weapon skill damage +5%','Accuracy+2 Attack+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Rajas Ring",
		right_ring={ name="Beithir Ring", augments={'Path: A',}},
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring",hands="Jhakri Cuffs +2",legs="Carmine Cuisses +1"})
	sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Savage Blade'].DT = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS['Savage Blade'], {})

	sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']
	sets.precast.WS['Vorpal Blade'].Acc = sets.precast.WS['Chant du Cygne'].Acc
	sets.precast.WS['Vorpal Blade'].FullAcc = sets.precast.WS['Chant du Cygne'].FullAcc
	sets.precast.WS['Vorpal Blade'].DT = sets.precast.WS['Chant du Cygne'].DT
	sets.precast.WS['Vorpal Blade'].Fodder = sets.precast.WS['Chant du Cygne'].Fodder

	sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Expiacion'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Expiacion'].DT = set_combine(sets.precast.WS.DT, {})
	sets.precast.WS['Expiacion'].Fodder = set_combine(sets.precast.WS['Expiacion'], {})

	sets.precast.WS['Sanguine Blade'] = {    
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}
					 
	sets.precast.WS['Sanguine Blade'].DT = set_combine(sets.precast.WS['Sanguine Blade'], {})

	sets.precast.WS['Flash Nova'] = {    
		ammo="Ghastly Tathlum +1",
		body="Cohort Cloak +1",
		hands="Jhakri Cuffs +2",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet={ name="Herculean Boots", augments={'STR+7','Mag. Acc.+15','Weapon skill damage +5%','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}
					 
	sets.precast.WS['Flash Nova'].DT = set_combine(sets.precast.WS['Flash Nova'], {})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring"}
	sets.AccMaxTP = {}

	-- Midcast Sets
	sets.midcast.FastRecast = {}

	sets.midcast['Blue Magic'] = {}

	-- Physical Spells --

	sets.midcast['Blue Magic'].Physical = {}

	sets.midcast['Blue Magic'].Physical.Resistant = {}

	sets.midcast['Blue Magic'].Physical.Fodder = {}

	sets.midcast['Blue Magic'].PhysicalAcc = {}

	sets.midcast['Blue Magic'].PhysicalAcc.Resistant = set_combine(sets.midcast['Blue Magic'].PhysicalAcc, {})
	sets.midcast['Blue Magic'].PhysicalAcc.Fodder = sets.midcast['Blue Magic'].Fodder

	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalStr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalStr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalDex.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalDex.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalVit.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalVit.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalInt.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalInt.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalChr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalChr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalHP.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalHP.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	-- Magical Spells --

	sets.midcast['Blue Magic'].Magical = {    
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet="Jhakri Pigaches +2",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}
					 
	sets.midcast['Blue Magic'].Magical.Proc = {    
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet="Jhakri Pigaches +2",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}
					 
	sets.midcast['Blue Magic'].Magical.Resistant = {    
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet="Jhakri Pigaches +2",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}

	sets.midcast['Blue Magic'].Magical.Fodder = {    
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet="Jhakri Pigaches +2",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}

	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {ring2="Stikini Ring"})
	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Blue Magic'].MagicAccuracy = {    
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet="Jhakri Pigaches +2",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}

	sets.midcast['Enfeebling Magic'] = {    
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet="Jhakri Pigaches +2",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}

	sets.midcast['Dark Magic'] = {    
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet="Jhakri Pigaches +2",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}

	sets.midcast['Enhancing Magic'] = {    
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet="Jhakri Pigaches +2",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
	}
		
	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'],{})

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})

	sets.midcast['Divine Magic'] = {}

	sets.midcast['Elemental Magic'] = {}

	sets.midcast['Elemental Magic'].Resistant = {}

	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant

	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}
	sets.element.Light = {} --ring2="Weatherspoon Ring"

	sets.midcast.Cure = {}

	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})

	-- Breath Spells --

	sets.midcast['Blue Magic'].Breath = {}

	-- Physical Added Effect Spells most notably "Stun" spells --

	sets.midcast['Blue Magic'].Stun = {}

	sets.midcast['Blue Magic'].Stun.Resistant = {}

	sets.midcast['Blue Magic'].Stun.Fodder = sets.midcast['Blue Magic'].Stun

	-- Other Specific Spells --

	sets.midcast['Blue Magic']['White Wind'] = {}
					
	sets.midcast['Blue Magic']['Healing Breeze'] = sets.midcast['Blue Magic']['White Wind']

	sets.midcast['Blue Magic'].Healing = {}

	--Overwrite certain spells with these peices even if the day matches, because of resource inconsistancies.
	sets.NonElementalCure = {}

	sets.midcast['Blue Magic'].SkillBasedBuff = {}

	sets.midcast['Blue Magic'].Buff = {}

	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff, {})

	sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {})

	sets.midcast['Blue Magic']['Cruel Joke'] = {
	    ammo="Impatiens",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands="Malignance Gloves",
		legs="Aya. Cosciales +2",
		feet="Malignance Boots",
		neck="Erra Pendant",
		waist="Sacro Cord",
		left_ear="Hermetic Earring",
		right_ear="Gwati Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back="Moonbeam Cape",
	}
	
	sets.midcast['Blue Magic']['Absolute Terror'] = set_combine(sets.midcast['Blue Magic']['Cruel Joke'], {})
	
	sets.midcast['Blue Magic']['Blistering Roar'] = set_combine(sets.midcast['Blue Magic']['Cruel Joke'], {})
	
	sets.midcast['Blue Magic']['Dream Flower'] = {
	    ammo="Impatiens",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands="Malignance Gloves",
		legs="Aya. Cosciales +2",
		feet="Malignance Boots",
		neck="Erra Pendant",
		waist="Sacro Cord",
		left_ear="Hermetic Earring",
		right_ear="Gwati Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back="Moonbeam Cape",
	}
	
	sets.midcast['Blue Magic']['Sudden Lunge'] = {
	    ammo="Impatiens",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands="Malignance Gloves",
		legs="Aya. Cosciales +2",
		feet="Malignance Boots",
		neck="Erra Pendant",
		waist="Sacro Cord",
		left_ear="Hermetic Earring",
		right_ear="Gwati Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back="Moonbeam Cape",
	}
	
	-- Sets to return to when not performing an action.

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Gear for learning spells: +skill and AF hands.
	sets.Learning = {}

	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle = {
		ammo="Ginsen",
		head="Rawhide mask",
		body="Jhakri Robe +2",
		hands={ name="Herculean Gloves", augments={'MND+4','Pet: DEX+11','"Refresh"+1',}},
		legs="Aya. Cosciales +2",
		feet={ name="Herculean Boots", augments={'INT+5','Magic burst dmg.+2%','"Refresh"+2','Accuracy+12 Attack+12',}},
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Flume Belt",
		left_ear="Cessance Earring",
		right_ear="Hearty Earring",
		left_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -6%',}},
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.idle.Sphere = set_combine(sets.idle, {})

	sets.idle.PDT = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Jhakri Robe +2",
		hands={ name="Herculean Gloves", augments={'MND+4','Pet: DEX+11','"Refresh"+1',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Herculean Boots", augments={'INT+5','Magic burst dmg.+2%','"Refresh"+2','Accuracy+12 Attack+12',}},
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Flume Belt",
		left_ear="Cessance Earring",
		right_ear="Hearty Earring",
		left_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -6%',}},
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.idle.DTHippo = set_combine(sets.idle.PDT, {legs="Carmine Cuisses +1"})

	-- Defense sets
	sets.defense.PDT = {}

	sets.defense.MDT = {}

    sets.defense.MEVA = {}

	sets.defense.NukeLock = sets.midcast['Blue Magic'].Magical

	sets.Kiting = {legs="Carmine Cuisses +1"}

    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
    sets.MP = {waist="Flume Belt",ear1="Suppanomimi"}
    sets.MP_Knockback = {}
	sets.SuppaBrutal = {ear1="Suppanomimi", ear2="Brutal Earring"}
	sets.DWEarrings = {}
	sets.DWMax = {}
	
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		head={ name="Herculean Helm", augments={'"Fast Cast"+2','"Drain" and "Aspir" potency +1','"Treasure Hunter"+2','Accuracy+10 Attack+10','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
		feet={ name="Herculean Boots", augments={'STR+10','Attack+8','"Treasure Hunter"+2','Accuracy+16 Attack+16','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
		}
	)
	
	-- Weapons sets
	sets.weapons.Tiz = {main="Tizona",sub="Naegling"}
	sets.weapons.TizTP = {main="Tizona",sub="Machaera +2"}
	sets.weapons.MeleeClubs = {main="Maxentius",sub="Machaera +2"}
	sets.weapons.MagicWeapons = {main="Tizona",sub="Maxentius"}
	sets.weapons.HybridWeapons = {main="Tizona",sub="Mafic Cudgel"}

	-- Engaged sets

	sets.engaged = {    
		ammo="Ginsen",
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands="Malignance Gloves",
		legs="Gleti's Breeches",
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Clotharius Torque",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Crep. Earring",
		left_ring="Petrov Ring",
		right_ring="Hetairoi Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.AM = {    
		ammo="Ginsen",
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands="Malignance Gloves",
		legs="Gleti's Breeches",
		feet="Malignance Boots",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Crep. Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}


	sets.engaged.Acc = {    
		ammo="Ginsen",
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands="Malignance Gloves",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Malignance Boots",
		neck="Clotharius Torque",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Crep. Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.Acc.AM = {    
		ammo="Ginsen",
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands="Malignance Gloves",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Malignance Boots",
		neck="Clotharius Torque",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Crep. Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.FullAcc = {    
		ammo="Ginsen",
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands="Malignance Gloves",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Malignance Boots",
		neck="Clotharius Torque",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Crep. Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.FullAcc.AM = {    
		ammo="Ginsen",
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands="Malignance Gloves",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Malignance Boots",
		neck="Clotharius Torque",
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Crep. Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.Fodder = {    
		ammo="Ginsen",
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands="Malignance Gloves",
		legs="Gleti's Breeches",
		feet="Malignance Boots",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Dedition Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.Fodder.AM = {    
		ammo="Ginsen",
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands="Malignance Gloves",
		legs="Gleti's Breeches",
		feet="Malignance Boots",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Dedition Earring",
		left_ring="Petrov Ring",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.DT = {    
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Gleti's Breeches",
		feet="Malignance Boots",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Crep. Earring",
		left_ring="Petrov Ring",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.DT.AM = {    
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Gleti's Breeches",
		feet="Malignance Boots",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Dedition Earring",
		left_ring="Petrov Ring",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.Acc.DT = {    
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Gleti's Breeches",
		feet="Malignance Boots",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Flume belt",
		left_ear="Cessance Earring",
		right_ear="Dedition Earring",
		left_ring="Petrov Ring",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
				
	sets.engaged.Acc.DT.AM = {    
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Gleti's Breeches",
		feet="Malignance Boots",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Flume belt",
		left_ear="Cessance Earring",
		right_ear="Dedition Earring",
		left_ring="Petrov Ring",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.FullAcc.DT = {    
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Gleti's Breeches",
		feet="Malignance Boots",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Flume belt",
		left_ear="Cessance Earring",
		right_ear="Dedition Earring",
		left_ring="Petrov Ring",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.Fodder.DT = {    
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Gleti's Breeches",
		feet="Malignance Boots",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Flume belt",
		left_ear="Cessance Earring",
		right_ear="Dedition Earring",
		left_ring="Petrov Ring",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.Fodder.DT.AM = {    
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Gleti's Breeches",
		feet="Malignance Boots",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Flume belt",
		left_ear="Cessance Earring",
		right_ear="Dedition Earring",
		left_ring="Petrov Ring",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.engaged.Counter = {    
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Aya. Cosciales +2",
		feet="Malignance Boots",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Flume Belt",
		left_ear="Dedition Earring",
		right_ear="Suppanomimi",
		left_ring="Rajas Ring",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+6','Crit.hit rate+10','System: 1 ID: 640 Val: 4',}},
	}
	
	sets.engaged.Crits = {    
		ammo="Ginsen",
		head="Malignance Chapeau",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands="Malignance Gloves",
		legs="Gleti's Breeches",
		feet="Malignance Boots",
		neck="Lissome Necklace",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Odr Earring",
		right_ear="Suppanomimi",
		left_ring="Rajas Ring",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+6','Crit.hit rate+10','System: 1 ID: 640 Val: 4',}},
	}

	sets.engaged.Counter.AM = set_combine(sets.engaged.Counter, {})
	sets.engaged.Crits.AM = set_combine(sets.engaged.Crits, {})

	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
	sets.MagicBurst = {}
	sets.Phalanx_Received = {}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 7)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 7)
	elseif player.sub_job == 'WAR' then
		set_macro_page(1, 7)
	elseif player.sub_job == 'RUN' then
		set_macro_page(1, 7)
	elseif player.sub_job == 'THF' then
		set_macro_page(1, 7)
	elseif player.sub_job == 'RDM' then
		set_macro_page(1, 7)
	else
		set_macro_page(1, 7)
	end
end

--Job Specific Trust Override
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()

				if spell_recasts[980] < spell_latency and not have_trust("Yoran-Oran") then
					windower.chat.input('/ma "Yoran-Oran (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.chat.input('/ma "Koru-Moru" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.chat.input('/ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.chat.input('/ma "Ulmia" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
					windower.chat.input('/ma "Selh\'teus" <me>')
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
	if player.equipment.main == nil or player.equipment.main == 'empty' then
		windower.chat.input('/lockstyleset 013')
	elseif res.items[item_name_to_id(player.equipment.main)].skill == 3 then --Sword in main hand.
		if player.equipment.sub == nil or player.equipment.sub == 'empty' then --Sword/Nothing.
			windower.chat.input('/lockstyleset 013')
		elseif res.items[item_name_to_id(player.equipment.sub)].shield_size then --Sword/Shield
			windower.chat.input('/lockstyleset 013')
		elseif res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Sword/Sword.
			windower.chat.input('/lockstyleset 013')
		elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Sword/Dagger.
			windower.chat.input('/lockstyleset 013')
		else
			windower.chat.input('/lockstyleset 013') --Catchall just in case something's weird.
		end
	elseif res.items[item_name_to_id(player.equipment.main)].skill == 2 then --Dagger in main hand.
		if player.equipment.sub == nil or player.equipment.sub == 'empty' then --Dagger/Nothing.
			windower.chat.input('/lockstyleset 013')
		elseif res.items[item_name_to_id(player.equipment.sub)].shield_size then --Dagger/Shield
			windower.chat.input('/lockstyleset 013')
		elseif res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Dagger/Sword.
			windower.chat.input('/lockstyleset 013')
		elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Dagger/Dagger.
			windower.chat.input('/lockstyleset 013')
		else
			windower.chat.input('/lockstyleset 013') --Catchall just in case something's weird.
		end
	end
end