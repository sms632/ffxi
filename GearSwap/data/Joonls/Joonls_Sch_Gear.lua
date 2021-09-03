-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal','Resistant','Proc','OccultAcumen','9k')
    state.IdleMode:options('Normal','PDT')
	state.HybridMode:options('Normal','PDT')
	state.Weapons:options('None','Akademos','Clubs')

	gear.nuke_jse_back = {name="Lugh's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10'}}
	
	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_waist = "Refoccilation Stone"
	gear.obi_high_nuke_waist = "Refoccilation Stone"
	
		-- Additional local binds
		--^ = control
		--! = alt
		--@ = windows
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c scholar power')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen')
	send_command('bind !q gs c weapons default;gs c reset CastingMode')
	send_command('bind ^w gs c cycle weapons;')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
	send_command('bind @^` input /ja "Parsimony" <me>')
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command('bind !backspace gs c scholar speed')
	send_command('bind @backspace gs c scholar aoe')
	send_command('bind ^= input /ja "Dark Arts" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise III" <me>')
	
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = {legs="Peda. Pants +1"}
	sets.precast.JA['Enlightenment'] = {} --body="Peda. Gown +1"

    -- Fast cast sets for spells

    sets.precast.FC = {
		ammo="Sapience Orb",
		head="Nahtirah Hat",
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+21','"Fast Cast"+6','CHR+8','Mag. Acc.+6',}},
		neck="Voltsurge Torque",
		waist="Embla Sash",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back="Fi Follet Cape +1",
	}
		
	sets.precast.FC.Arts = {}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear1="Malignance Earring"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body="Twilight Cloak"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Ammurapi Shield"})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS['Myrkr'] = {
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body={ name="Vanya Robe", augments={'MP+49','"Cure" potency +7%','Enmity-5',}},
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Voltsurge Torque",
		waist={ name="Acuity Belt +1", augments={'Path: A',}},
		left_ear="Evans Earring",
		right_ear="Loquac. Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Zodiac Ring",
		back="Pahtli Cape",
	}

    -- Midcast Sets

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		head="Wh. Rarab Cap +1",
		hands={ name="Chironic Gloves", augments={'Sklchn.dmg.+3%','STR+4','"Treasure Hunter"+2',}},
		waist="Chaac Belt",
		
	})
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Seidr Cotehardie"}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {
		main={ name="Akademos", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Spell interruption rate down -7%','Pet: VIT+3','"Refresh"+2',}},
		neck="Mizu. Kubikazari",
		left_ear="Static Earring",
		left_ring="Mujin Band",
	}
	
	-- Gear for specific elemental nukes.
	sets.element.Dark = {head="Pixie Hairpin +1", ring2="Archon Ring"}

    sets.midcast.FastRecast = {
		main={ name="Grioavolr", augments={'Enh. Mag. eff. dur. +9','CHR+13','Mag. Acc.+28','"Mag.Atk.Bns."+14',}},
		sub="Kaja Grip",
		ammo="Impatiens",
		head={ name="Merlinic Hood", augments={'Rng.Atk.+4','Pet: DEX+14','"Refresh"+2',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+21','"Fast Cast"+6','CHR+8','Mag. Acc.+6',}},
		neck="Voltsurge Torque",
		waist="Embla Sash",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Weather. Ring",
		right_ring="Kishar Ring",
	}
		
    sets.midcast.Cure = {
		main="Chatoyant Staff",
		sub="Kaja Grip",
		ammo="Impatiens",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Vanya Robe", augments={'MP+49','"Cure" potency +7%','Enmity-5',}},
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
		neck="Voltsurge Torque",
		waist="Embla Sash",
		left_ear="Mendi. Earring",
		right_ear="Malignance Earring",
		left_ring="Weather. Ring",
		right_ring="Kishar Ring",
		back="Solemnity Cape",
	}
		
    sets.midcast.LightWeatherCure = {
		main="Chatoyant Staff",
		sub="Kaja Grip",
		ammo="Impatiens",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Vanya Robe", augments={'MP+49','"Cure" potency +7%','Enmity-5',}},
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
		neck="Voltsurge Torque",
		waist="Embla Sash",
		left_ear="Mendi. Earring",
		right_ear="Malignance Earring",
		left_ring="Weather. Ring",
		right_ring="Kishar Ring",
		back="Solemnity Cape",
	}
		
    sets.midcast.LightDayCure = {
		main="Chatoyant Staff",
		sub="Kaja Grip",
		ammo="Impatiens",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Vanya Robe", augments={'MP+49','"Cure" potency +7%','Enmity-5',}},
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
		neck="Voltsurge Torque",
		waist="Embla Sash",
		left_ear="Mendi. Earring",
		right_ear="Malignance Earring",
		left_ring="Weather. Ring",
		right_ring="Kishar Ring",
		back="Solemnity Cape",
	}

    sets.midcast.Curaga = sets.midcast.Cure

	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
	
	sets.midcast.Cursna = {
		ammo="Impatiens",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Vanya Robe", augments={'MP+49','"Cure" potency +7%','Enmity-5',}},
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Mendi. Earring",
		right_ear="Malignance Earring",
		left_ring="Ephedra Ring",
		right_ring="Sirona's Ring",
		back="Solemnity Cape",
	}
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	sets.midcast['Enhancing Magic'] = {
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','MND+5','Mag. Acc.+6','"Mag.Atk.Bns."+4',}},
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head={ name="Telchine Cap", augments={'Mag. Evasion+12','"Elemental Siphon"+25','Enh. Mag. eff. dur. +7',}},
		body={ name="Telchine Chas.", augments={'Mag. Evasion+4','"Cure" spellcasting time -6%','Enh. Mag. eff. dur. +8',}},
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%',}},
		legs={ name="Telchine Braconi", augments={'"Mag.Atk.Bns."+10','"Elemental Siphon"+35','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Evasion+2','"Elemental Siphon"+35','Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
		waist="Cascade Belt",
		left_ear="Andoaa Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back="Solemnity Cape",
	}

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		back={ name="Bookworm's Cape", augments={'INT+4','MND+2','"Regen" potency+9',}},
	})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Shellra = sets.midcast.Shell


    -- Custom spell classes

	sets.midcast['Enfeebling Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Sapience Orb",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Erra Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Crep. Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}
	
	sets.midcast['Enfeebling Magic'].Resistant = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Sapience Orb",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Erra Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Crep. Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {ring2="Stikini Ring "})

    sets.midcast['Dark Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Sapience Orb",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Erra Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Crep. Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}
	
	sets.midcast.Embrava = {
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','MND+5','Mag. Acc.+6','"Mag.Atk.Bns."+4',}},
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head={ name="Telchine Cap", augments={'Mag. Evasion+12','"Elemental Siphon"+25','Enh. Mag. eff. dur. +7',}},
		body={ name="Telchine Chas.", augments={'Mag. Evasion+4','"Cure" spellcasting time -6%','Enh. Mag. eff. dur. +8',}},
		hands="Arbatel Bracers +1",
		legs={ name="Telchine Braconi", augments={'"Mag.Atk.Bns."+10','"Elemental Siphon"+35','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Evasion+2','"Elemental Siphon"+35','Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
		waist="Cascade Belt",
		left_ear="Andoaa Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back="Solemnity Cape",
	}

    sets.midcast.Kaustra = {
		main={ name="Akademos", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Kaja Grip",
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Kishar Ring",
		right_ring="Archon Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}
		
    sets.midcast.Kaustra.Resistant = {
		main={ name="Akademos", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Kaja Grip",
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Kishar Ring",
		right_ring="Archon Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}

    sets.midcast.Drain = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Sapience Orb",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Erra Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Crep. Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}
		
    sets.midcast.Drain.Resistant = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Sapience Orb",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Erra Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Crep. Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}

    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

    sets.midcast.Stun = {
		main={ name="Grioavolr", augments={'Enh. Mag. eff. dur. +9','CHR+13','Mag. Acc.+28','"Mag.Atk.Bns."+14',}},
		sub="Kaja Grip",
		ammo="Sapience Orb",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+21','"Fast Cast"+6','CHR+8','Mag. Acc.+6',}},
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}

    sets.midcast.Stun.Resistant = {
		main={ name="Grioavolr", augments={'Enh. Mag. eff. dur. +9','CHR+13','Mag. Acc.+28','"Mag.Atk.Bns."+14',}},
		sub="Kaja Grip",
		ammo="Sapience Orb",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+21','"Fast Cast"+6','CHR+8','Mag. Acc.+6',}},
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}

    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}

    sets.midcast['Elemental Magic'].Resistant = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}
		
    sets.midcast['Elemental Magic'].Fodder = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}
		
    sets.midcast['Elemental Magic']['9k'] = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}
		
    sets.midcast['Elemental Magic'].Proc = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		head="Nahtirah Hat",
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+21','"Fast Cast"+6','CHR+8','Mag. Acc.+6',}},
		neck="Voltsurge Torque",
		waist="Embla Sash",
		left_ear="Malignance Earring",
		right_ear="Barkaro. Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}
		
    sets.midcast['Elemental Magic'].OccultAcumen = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}
		
    -- Custom refinements for certain nuke tiers
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {})

	sets.midcast.Helix = {
		main="Akademos",
		sub="Kaja Grip",
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands="Mallquis Cuffs +2",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+9%','INT+9','"Mag.Atk.Bns."+10',}},
		neck={ name="Argute Stole +1", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Barkaro. Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Mallquis Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}
	
	sets.midcast.Helix.Resistant = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands="Mallquis Cuffs +2",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+9%','INT+9','"Mag.Atk.Bns."+10',}},
		neck={ name="Argute Stole +1", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Barkaro. Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Mallquis Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}
		
	sets.midcast.Helix.Proc = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands="Mallquis Cuffs +2",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+9%','INT+9','"Mag.Atk.Bns."+10',}},
		neck={ name="Argute Stole +1", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Barkaro. Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Mallquis Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}

	sets.midcast.Impact = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		head=empty,
		body="Twilight Cloak",
		hands="Jhakri Cuffs +2",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Acumen Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+2','"Mag.Atk.Bns."+10',}},
	}
		
    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {head=empty,body="Twilight Cloak"})
		
    -- Sets to return to when not performing an action.

     -- Resting sets
    sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
		main="Malignance Pole",
		sub="Kaja Grip",
		ammo="Homiliary",
		head={ name="Merlinic Hood", augments={'Rng.Atk.+4','Pet: DEX+14','"Refresh"+2',}},
		body="Jhakri Robe +2",
		hands="Nyame Gauntlets",
		legs={ name="Merlinic Shalwar", augments={'Spell interruption rate down -7%','Pet: VIT+3','"Refresh"+2',}},
		feet="Hippomenes Socks",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Static Earring",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Sheltered Ring",
		back="Solemnity Cape",
	}

    sets.idle.PDT = {
		main="Malignance Pole",
		sub="Kaja Grip",
		ammo="Homiliary",
		head={ name="Merlinic Hood", augments={'Rng.Atk.+4','Pet: DEX+14','"Refresh"+2',}},
		body="Jhakri Robe +2",
		hands="Nyame Gauntlets",
		legs={ name="Merlinic Shalwar", augments={'Spell interruption rate down -7%','Pet: VIT+3','"Refresh"+2',}},
		feet="Hippomenes Socks",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Static Earring",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Sheltered Ring",
		back="Solemnity Cape",
	}
		
	sets.idle.Hippo = set_combine(sets.idle.PDT, {feet="Hippo. Socks"})

    sets.idle.Weak = {
		main="Malignance Pole",
		sub="Kaja Grip",
		ammo="Homiliary",
		head={ name="Merlinic Hood", augments={'Rng.Atk.+4','Pet: DEX+14','"Refresh"+2',}},
		body="Jhakri Robe +2",
		hands="Nyame Gauntlets",
		legs={ name="Merlinic Shalwar", augments={'Spell interruption rate down -7%','Pet: VIT+3','"Refresh"+2',}},
		feet="Hippomenes Socks",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Static Earring",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Sheltered Ring",
		back="Solemnity Cape",
	}
		
    -- Defense sets

    sets.defense.PDT = {
		main="Malignance Pole",
		sub="Kaja Grip",
		ammo="Homiliary",
		head={ name="Merlinic Hood", augments={'Rng.Atk.+4','Pet: DEX+14','"Refresh"+2',}},
		body="Jhakri Robe +2",
		hands="Nyame Gauntlets",
		legs={ name="Merlinic Shalwar", augments={'Spell interruption rate down -7%','Pet: VIT+3','"Refresh"+2',}},
		feet="Hippomenes Socks",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Static Earring",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Sheltered Ring",
		back="Solemnity Cape",
	}

    sets.defense.MDT = {
		main="Malignance Pole",
		sub="Kaja Grip",
		ammo="Homiliary",
		head={ name="Merlinic Hood", augments={'Rng.Atk.+4','Pet: DEX+14','"Refresh"+2',}},
		body="Jhakri Robe +2",
		hands="Nyame Gauntlets",
		legs={ name="Merlinic Shalwar", augments={'Spell interruption rate down -7%','Pet: VIT+3','"Refresh"+2',}},
		feet="Hippomenes Socks",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Static Earring",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Sheltered Ring",
		back="Solemnity Cape",
	}
		
    sets.defense.MEVA = {
		main="Malignance Pole",
		sub="Kaja Grip",
		ammo="Homiliary",
		head={ name="Merlinic Hood", augments={'Rng.Atk.+4','Pet: DEX+14','"Refresh"+2',}},
		body="Jhakri Robe +2",
		hands="Nyame Gauntlets",
		legs={ name="Merlinic Shalwar", augments={'Spell interruption rate down -7%','Pet: VIT+3','"Refresh"+2',}},
		feet="Hippomenes Socks",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Static Earring",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Sheltered Ring",
		back="Solemnity Cape",
	}
		
    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}
	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
		main="Maxentius",
		ammo="Homiliary",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Lissome Necklace",
		waist="Eschan Stone",
		left_ear="Suppanomimi",
		right_ear="Crep. Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back="Moonbeam Cape",
	}
		
	sets.engaged.PDT = {
		main="Malignance Pole",
		sub="Kaja Grip",
		ammo="Homiliary",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Lissome Necklace",
		waist="Eschan Stone",
		left_ear="Suppanomimi",
		right_ear="Crep. Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back="Solemnity Cape",
	}
		
	sets.engaged.DW = {
		main="Maxentius",
		sub="Daybreak",
		ammo="Homiliary",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Lissome Necklace",
		waist="Eschan Stone",
		left_ear="Suppanomimi",
		right_ear="Crep. Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back="Solemnity Cape",
	}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = {}
    sets.buff['Rapture'] = {}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers +1"}
    sets.buff['Penury'] = {}
    sets.buff['Parsimony'] = {}
    sets.buff['Celerity'] = {feet="Peda. Loafers +1"}
    sets.buff['Alacrity'] = {feet="Peda. Loafers +1"}
    sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}
	
	sets.HPDown = {}
		
    sets.HPCure = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff['Light Arts'] = {} --legs="Academic's Pants +3"
	sets.buff['Dark Arts'] = {} --body="Academic's Gown +3"

    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
	-- Weapons sets
	sets.weapons.Akademos = {main="Akademos",sub="Kaja Grip"}
	sets.weapons.Clubs = {main="Maxentius", sub="Daybreak"}
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'RDM' then
		set_macro_page(1, 19)
	elseif player.sub_job == 'BLM' then
		set_macro_page(1, 19)
	elseif player.sub_job == 'WHM' then
		set_macro_page(1, 19)
	else
		set_macro_page(1, 19)
	end
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 012') --Catchall just in case something's weird.
end