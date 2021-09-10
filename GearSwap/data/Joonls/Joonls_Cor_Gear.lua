-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal','Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match','Normal', 'Acc','Proc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
	state.HybridMode:options('Normal','DT')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMax'}
	state.Weapons:options('Default','DualWeapons','MeleeLeaden','PhantomLanun','ShootingLeaden','DualSavageWeapons','DemersalSavage','DemersalLeaden','DualLeadenRanged','DualLeadenMelee','DualAeolian','DualLeadenMeleeAcc','DualRanged','Evis','None')
	state.CompensatorMode:options('Always','300','1000','Never')
	
	state.LuzafRing = M(false, "Luzaf's Ring")

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Orichalcum Bullet" --For MAB WS, do not put single-use bullets here.
    gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 15

	gear.tp_cor_jse_back 		= {name="Camulus's Mantle",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}}
	gear.snapshot_jse_back 		= {name="Camulus's Mantle",augments={'"Snapshot"+10',}}
	gear.tp_jse_back 			= {name="Camulus's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	gear.corsair_wsd_jse_back 	= {name="Camulus's Mantle",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	gear.magic_wsd_jse_back 	= {name="Camulus's Mantle",augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	gear.str_wsd_jse_back 		= {name="Camulus's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.cor_roll_back			= { name="Gunslinger's Cape", augments={'Enmity-4','"Mag.Atk.Bns."+1','"Phantom Roll" ability delay -5',}}

    -- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c elemental quickdraw')
	
	send_command('bind ^backspace input /ja "Double-up" <me>')
	send_command('bind @backspace input /ja "Snake Eye" <me>')
	send_command('bind !backspace input /ja "Fold" <me>')
	send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')
	
    send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
	send_command('bind ^@!\\\\ gs c toggle LuzafRing')
	send_command('bind @f7 gs c toggle RngHelper')
	
	send_command('bind ^w gs c cycle weapons')
	send_command('bind ^q gs c cycle CompensatorMode')
	send_command('bind @pause roller roll')
	
	send_command('bind !w input /ws "Savage Blade" <t>') 			-- Alt-w Savage Blade Shortcut.

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +1"}
    sets.precast.JA['Snake Eye'] = {}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}

    sets.precast.CorsairRoll = {
		main={ name="Lanun Knife", augments={'Path: C',}},
		range="Compensator",
        head="Lanun Tricorne +1",
		-- neck="Regal Necklace",
		-- ear1="Etiolation Earring",
		-- ear2="Sanare Earring",
        body="Lanun Frac +3",
		hands="Chasseur's Gants +1",
		ring1="Barataria Ring",
		ring2="Luzaf's Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Phys. dmg. taken-10%',}},
		waist="Flume Belt",
		-- legs="Desultor Tassets",
		feet="Malignance Boots"
	}

    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes +1"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes +1"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +1"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's frac +1",})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})
    
    sets.precast.CorsairShot = {
		ammo=gear.QDbullet,
		head="Malignance Chapeau",
		body="Lanun Frac +3",
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet="Chass. Bottes +1",
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Dingir Ring",
		right_ring="Acumen Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
		
	sets.precast.CorsairShot.Damage = {
		ammo=gear.QDbullet,
		head="Malignance Chapeau",
		body="Lanun Frac +3",
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet="Chass. Bottes +1",
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Dingir Ring",
		right_ring="Acumen Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
    sets.precast.CorsairShot.Proc = {
		head="Malignance Chapeau",
		body="Lanun Frac +3",
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet="Chass. Bottes +1",
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Dingir Ring",
		right_ring="Acumen Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

    sets.precast.CorsairShot['Light Shot'] = {
		ammo=gear.QDbullet,
		head="Malignance Chapeau",
		body={ name="Herculean Vest", augments={'"Snapshot"+4','DEX+6','Quadruple Attack +3','Accuracy+16 Attack+16','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet="Malignance Boots",
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Dingir Ring",
		right_ring="Acumen Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

    sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot['Light Shot'], {feet="Chass. Bottes +1"})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = set_combine(sets.defense.PDT, {body="Passion Jacket"})
		
	sets.Self_Waltz = set_combine(sets.defense.PDT, {body="Passion Jacket"})
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		head={ name="Herculean Helm", augments={'"Fast Cast"+2','"Drain" and "Aspir" potency +1','"Treasure Hunter"+2','Accuracy+10 Attack+10','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
		body={ name="Taeon Tabard", augments={'Accuracy+9','"Snapshot"+4','"Snapshot"+4',}},
		hands="Leyline Gloves",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Malignance Boots",
		neck="Baetyl Pendant",
		waist="Flume Belt",
		right_ear="Loquac. Earring",
		left_ring="Defending Ring",
		right_ring="Weather. Ring",
	}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket"})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {ear2="Mendi. Earring"})

    sets.precast.RA = {
		head={ name="Taeon Chapeau", augments={'Accuracy+11','"Snapshot"+4','"Snapshot"+4',}},
		body={ name="Taeon Tabard", augments={'Accuracy+9','"Snapshot"+4','"Snapshot"+4',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
		feet="Meg. Jam. +2",
		neck={ name="Comm. Charm +1", augments={'Path: A',}},
		waist="Impulse Belt",
		left_ring="Defending Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'"Snapshot"+10',}},
	}
		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, {
		body="Laksa. Frac +2",
		feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},
	})
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA, {
		head="Chass. Tricorne +1",
		body="Laksa. Frac +2",
		feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},
	})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head={ name="Herculean Helm", augments={'Rng.Acc.+22','Pet: "Regen"+2','Weapon skill damage +7%','Accuracy+9 Attack+9','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		body="Laksa. Frac +2",
		hands="Meg. Gloves +2",
		legs={ name="Herculean Trousers", augments={'"Dbl.Atk."+2','CHR+9','Weapon skill damage +5%','Accuracy+2 Attack+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
	}
		
    sets.precast.WS.Acc = {
        head="Malignance Chapeau",
		body="Laksa. Frac +2",
		hands="Meg. Gloves +2",
		legs={ name="Herculean Trousers", augments={'"Dbl.Atk."+2','CHR+9','Weapon skill damage +5%','Accuracy+2 Attack+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
	}	
		
    sets.precast.WS.Proc = {
        head="Malignance Chapeau",
		body="Laksa. Frac +2",
		hands="Meg. Gloves +2",
		legs={ name="Herculean Trousers", augments={'"Dbl.Atk."+2','CHR+9','Weapon skill damage +5%','Accuracy+2 Attack+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
	}
		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		head={ name="Herculean Helm", augments={'Rng.Acc.+22','Pet: "Regen"+2','Weapon skill damage +7%','Accuracy+9 Attack+9','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		body="Laksa. Frac +2",
		hands="Meg. Gloves +2",
		legs={ name="Herculean Trousers", augments={'"Dbl.Atk."+2','CHR+9','Weapon skill damage +5%','Accuracy+2 Attack+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Sailfi Belt +1",
		left_ring="Metamorph Ring +1",
	})

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {})
	
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Savage Blade'], {})
	
    sets.precast.WS['Last Stand'] = {
		ammo=gear.WSbullet,
		head={ name="Herculean Helm", augments={'Rng.Acc.+22','Pet: "Regen"+2','Weapon skill damage +7%','Accuracy+9 Attack+9','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		body="Laksa. Frac +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
	}

    sets.precast.WS['Last Stand'].Acc = {
		ammo=gear.WSbullet,
        head="Malignance Chapeau",
		body="Laksa. Frac +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
	}
		
    sets.precast.WS['Detonator'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Detonator'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Slug Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Slug Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Numbing Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Numbing Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Sniper Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Sniper Shot'].Acc = sets.precast.WS['Last Stand'].Acc
    sets.precast.WS['Split Shot'] = sets.precast.WS['Last Stand']
    sets.precast.WS['Split Shot'].Acc = sets.precast.WS['Last Stand'].Acc
	
    sets.precast.WS['Leaden Salute'] = {
		ammo=gear.MAbullet,
        head="Pixie Hairpin +1",
		body="Lanun Frac +3",
		hands="Carmine Fin. Ga. +1",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Dingir Ring",
		right_ring="Archon Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
	}

    sets.precast.WS['Aeolian Edge'] = {
		ammo=gear.MAbullet,
        head={ name="Herculean Helm", augments={'Rng.Acc.+22','Pet: "Regen"+2','Weapon skill damage +7%','Accuracy+9 Attack+9','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		body="Lanun Frac +3",
		hands="Meg. Gloves +2",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Dingir Ring",
		right_ring="Acumen Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
	}

    sets.precast.WS['Wildfire'] = {
		ammo=gear.MAbullet,
        head={ name="Herculean Helm", augments={'Rng.Acc.+22','Pet: "Regen"+2','Weapon skill damage +7%','Accuracy+9 Attack+9','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		neck="Baetyl Pendant",
		body="Lanun Frac +3",
		hands="Meg. Gloves +2",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
        waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Dingir Ring",
		right_ring="Acumen Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
	}

    sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS['Wildfire'], {})
    sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']
    sets.precast.WS['Hot Shot'].Acc = sets.precast.WS['Wildfire'].Acc
		
		--Because omen skillchains.
    sets.precast.WS['Burning Blade'] = {}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
        
    -- Midcast Sets
    sets.midcast.FastRecast = {}
        
    -- Specific spells

	sets.midcast.Cure = {ear2="Mendi. Earring"}
	
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    -- Ranged gear
    sets.midcast.RA = {
		ammo=gear.RAbullet,
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
		feet="Malignance Boots",
		neck={ name="Comm. Charm +1", augments={'Path: A',}},
		waist="Kwahu Kachina Belt",
		left_ear="Neritic Earring",
		right_ear="Dedition Earring",
		left_ring="Crepuscular Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

    sets.midcast.RA.Acc = {
		ammo=gear.RAbullet,
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
		feet="Malignance Boots",
		neck="Comm. Charm +1",
		waist="Kwahu Kachina Belt",
		left_ear="Neritic Earring",
		right_ear="Cessance Earring",
		left_ring="Crepuscular Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
		
	sets.buff['Triple Shot'] = {
		body="Chasseur's Frac +1",
		hands="Lanun Gants +3",
		feet="Oshosi Leggings",
		
	}
    
    -- Sets to return to when not performing an action.
	
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = {
		ammo=gear.RAbullet,
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		body="Malignance Tabard",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist="Flume Belt",
		left_ear="Static Earring",
		right_ear="Thureous Earring",
		left_ring="Defending Ring",
		right_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -6%',}},
		back="Moonbeam Cape",
	}
		
    sets.idle.PDT = {
		ammo=gear.RAbullet,
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		body="Malignance Tabard",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist="Flume Belt",
		left_ear="Static Earring",
		right_ear="Thureous Earring",
		left_ring="Defending Ring",
		right_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -6%',}},
		back="Moonbeam Cape",
	}
		
    sets.idle.Refresh = {
		ammo=gear.RAbullet,
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		body="Malignance Tabard",
		legs="Meg. Chausses +2",
		feet="Malignance boots",
		neck="Twilight Torque",
		waist="Flume Belt",
		left_ear="Static Earring",
		right_ear="Thureous Earring",
		left_ring="Defending Ring",
		right_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -6%',}},
		back="Moonbeam Cape",
	}
    
    -- Defense sets
    sets.defense.PDT = {
		ammo=gear.RAbullet,
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		body="Malignance Tabard",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist="Flume Belt",
		left_ear="Static Earring",
		right_ear="Thureous Earring",
		left_ring="Defending Ring",
		right_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -6%',}},
		back="Moonbeam Cape",
	}

    sets.defense.MDT = {
		ammo=gear.RAbullet,
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		body="Malignance Tabard",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist="Flume Belt",
		left_ear="Static Earring",
		right_ear="Thureous Earring",
		left_ring="Defending Ring",
		right_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -6%',}},
		back="Moonbeam Cape",
	}
		
    sets.defense.MEVA = {
		ammo=gear.RAbullet,
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		body="Malignance Tabard",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist="Flume Belt",
		left_ear="Static Earring",
		right_ear="Thureous Earring",
		left_ring="Defending Ring",
		right_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -6%',}},
		back="Moonbeam Cape",
	}
	
	sets.TreasureHunter = {
		head={ name="Herculean Helm", augments={'"Fast Cast"+2','"Drain" and "Aspir" potency +1','"Treasure Hunter"+2','Accuracy+10 Attack+10','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
		feet={ name="Herculean Boots", augments={'STR+10','Attack+8','"Treasure Hunter"+2','Accuracy+16 Attack+16','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
	}

    sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.DWMax = {body="Adhemar Jacket +1"}

	-- Weapons sets
	sets.weapons.Default = {main="Rostam",sub="Demers. Degen +1",range="Fomalhaut"}
	sets.weapons.MeleeLeaden = {main="Rostam",sub="Demers. Degen +1",range="Fomalhaut"}
	sets.weapons.PhantomLanun = {main={ name="Lanun Knife", augments={'Path: C',}},sub="Demers. Degen +1",range="Fomalhaut"}
	sets.weapons.ShootingLeaden = {main={ name="Lanun Knife", augments={'Path: A',}},sub="Tauret",range="Fomalhaut"}
	sets.weapons.DualWeapons = {main="Naegling",sub="Tauret",range="Fomalhaut"}
	sets.weapons.DualSavageWeapons = {main="Naegling",sub="Tauret",range="Anarchy +2"}
	sets.weapons.DemersalSavage = {main="Naegling",sub="Demers. Degen +1",range="Anarchy +2"}
	sets.weapons.DemersalLeaden = {main="Lanun Knife",sub="Demers. Degen +1",range="Fomalhaut"}
	sets.weapons.DualLeadenRanged = {main="Naegling",sub="Tauret",range="Fomalhaut"}
	sets.weapons.DualLeadenMelee = {main="Naegling",sub="Tauret",range="Fomalhaut"}
	sets.weapons.DualAeolian = {main="Tauret",sub="Naegling",range="Anarchy +2"}
	sets.weapons.DualLeadenMeleeAcc = {main="Naegling",sub="Tauret",range="Fomalhaut"}
	sets.weapons.DualRanged = {main={ name="Lanun Knife", augments={'Path: A',}},sub="Rostam",range="Fomalhaut"}
	sets.weapons.Evis = {main="Tauret",sub="Demers. Degen +1",range="Anarchy +2"}
	
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {    
		head="Adhemar Bonnet",
		body={ name="Herculean Vest", augments={'"Snapshot"+4','DEX+6','Quadruple Attack +3','Accuracy+16 Attack+16','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+20','"Triple Atk."+3','STR+7','Attack+14',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Clotharius Torque",
		waist="Sailfi Belt +1",
		left_ear="Suppanomimi",
		right_ear="Dedition Earring",
		left_ring="Epona's Ring",
		right_ring="Petrov Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
    
    sets.engaged.Acc = {    
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Carmine Cuisses +1",
		feet="Malignance Boots",
		neck="Clotharius Torque",
		waist="Sailfi Belt +1",
		left_ear="Suppanomimi",
		right_ear="Cessance Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
		
    sets.engaged.DT = {    
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Carmine Cuisses +1",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist="Sailfi Belt +1",
		left_ear="Suppanomimi",
		right_ear="Cessance Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
    
    sets.engaged.Acc.DT = {    
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Carmine Cuisses +1",
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist="Sailfi Belt +1",
		left_ear="Suppanomimi",
		right_ear="Cessance Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

    sets.engaged.DW = {    
		head="Adhemar Bonnet",
		body="Adhemar Jacket +1",
		hands={ name="Herculean Gloves", augments={'Accuracy+20','"Triple Atk."+3','STR+7','Attack+14',}},
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Clotharius Torque",
		waist="Sailfi Belt +1",
		left_ear="Suppanomimi",
		right_ear="Dedition Earring",
		left_ring="Epona's Ring",
		right_ring="Petrov Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
    
    sets.engaged.DW.Acc = {    
		head="Malignance Chapeau",
		body="Adhemar Jacket +1",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Clotharius Torque",
		waist="Sailfi Belt +1",
		left_ear="Suppanomimi",
		right_ear="Mache Earring",
		left_ring="Epona's Ring",
		right_ring="Petrov Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
		
    sets.engaged.DW.DT = {    
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Clotharius Torque",
		waist="Sailfi Belt +1",
		left_ear="Cessance Earring",
		right_ear="Dedition Earring",
		left_ring="Epona's Ring",
		right_ring="Petrov Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
    
    sets.engaged.DW.Acc.DT = {    
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
		neck="Clotharius Torque",
		waist="Sailfi Belt +1",
		left_ear="Suppanomimi",
		right_ear="Dedition Earring",
		left_ring="Epona's Ring",
		right_ring="Petrov Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}},
	}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'NIN' then
        set_macro_page(1, 11)
    elseif player.sub_job == 'DNC' then
		set_macro_page(1, 11)
    elseif player.sub_job == 'RNG' then
        set_macro_page(1, 11)
    elseif player.sub_job == 'DRG' then
        set_macro_page(1, 11)
    else
        set_macro_page(1, 11)
    end
end

function user_job_lockstyle()
	if player.equipment.main == nil or player.equipment.main == 'empty' then
		windower.chat.input('/lockstyleset 002')
	elseif res.items[item_name_to_id(player.equipment.main)].skill == 3 then --Sword in main hand.
		if player.equipment.sub == nil or player.equipment.sub == 'empty' then --Sword/Nothing.
			windower.chat.input('/lockstyleset 002')
		elseif res.items[item_name_to_id(player.equipment.sub)].shield_size then --Sword/Shield
			windower.chat.input('/lockstyleset 002')
		elseif res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Sword/Sword.
			windower.chat.input('/lockstyleset 002')
		elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Sword/Dagger.
			windower.chat.input('/lockstyleset 002')
		else
			windower.chat.input('/lockstyleset 002') --Catchall just in case something's weird.
		end
	elseif res.items[item_name_to_id(player.equipment.main)].skill == 2 then --Dagger in main hand.
		if player.equipment.sub == nil or player.equipment.sub == 'empty' then --Dagger/Nothing.
			windower.chat.input('/lockstyleset 002')
		elseif res.items[item_name_to_id(player.equipment.sub)].shield_size then --Dagger/Shield
			windower.chat.input('/lockstyleset 002')
		elseif res.items[item_name_to_id(player.equipment.sub)].skill == 3 then --Dagger/Sword.
			windower.chat.input('/lockstyleset 002')
		elseif res.items[item_name_to_id(player.equipment.sub)].skill == 2 then --Dagger/Dagger.
			windower.chat.input('/lockstyleset 002')
		else
			windower.chat.input('/lockstyleset 002') --Catchall just in case something's weird.
		end
	end
end