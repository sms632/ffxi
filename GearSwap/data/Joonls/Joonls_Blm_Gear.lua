function user_job_setup()
	-- Options: Override default values
	state.CastingMode:options('Normal','Resistant','Fodder','Proc','OccultAcumen')
	state.OffenseMode:options('Normal')
	state.IdleMode:options('Normal','PDT','DTHippo')
	state.Weapons:options('None','BurstWeapons','Khatvanga','Lathi','Pull')

		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode') 
	send_command('bind ~^` gs c cycleback ElementalMode') --Robbiewobbie's idea
	send_command('bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen')
	send_command('bind !q gs c weapons Default;gs c reset CastingMode;gs c reset DeathMode;gs c reset MagicBurstMode')
	send_command('bind !t gs c set DeathMode Single;gs c set MagicBurstMode Single')
	send_command('bind !\\\\ input /ja "Manawell" <me>')
	send_command('bind !` input /ma "Aspir III" <t>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f9 gs c cycle DeathMode')
	send_command('bind @^` input /ja "Parsimony" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation and Myrkr.
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command('bind !backspace input /ja "Enmity Douse" <t>')
	send_command('bind @backspace input /ja "Alacrity" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind @= input /ja "Addendum: White" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
    
	select_default_macro_book()
end

function init_gear_sets()

    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
	-- Weapons sets
	sets.weapons.BurstWeapons = {main=gear.grioavolr_nuke_staff, sub="Enki Strap"}
	sets.weapons.Lathi = {main="Lathi",sub="Kaja Grip"}
	sets.weapons.Khatvanga = {main="Khatvanga", sub="Kaja Grip"}
	sets.weapons.Pull = {main="Malignance Pole", sub="Kaja Grip"}
	
    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}	
	
	-- Treasure Hunter
	
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.merlinic_treasure_feet})
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
		feet="Wicce Sabots +1"
	}

    sets.precast.JA.Manafont = {} --body="Sorcerer's Coat +2"
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {    
		ammo="Sapience Orb",
		head="Nahtirah Hat",
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+21','"Fast Cast"+6','CHR+8','Mag. Acc.+6',}},
		neck="Baetyl Pendant",
		waist="Embla Sash",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Weather. Ring",
		right_ring="Prolix Ring",
		back="Taranus's Cape",
	}
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
		ammo="Staunch Tathlum +1", 
		ear1="Malignance Earring",
		ear2="Barkaro. Earring"
	})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Ammurapi Shield"})

	sets.precast.FC.Death = set_combine(sets.precast.FC, {})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {}

    sets.precast.WS['Myrkr'] = {
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body="Ea Houppelande",
		hands="Jhakri Cuffs +2",
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet={ name="Telchine Pigaches", augments={'Evasion+2','"Elemental Siphon"+35','Enh. Mag. eff. dur. +10',}},
		neck="Voltsurge Torque",
		waist={ name="Acuity Belt +1", augments={'Path: A',}},
		left_ear="Evans Earring",
		right_ear="Moonshade Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Mephitas's Ring +1",
		back="Pahtli Cape",
	}
		
	sets.MaxTPMyrkr = {ear1="Evans Earring",ear2="Loquac. Earring"}
    
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {    
		ammo="Sapience Orb",
		head="Nahtirah Hat",
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+21','"Fast Cast"+6','CHR+8','Mag. Acc.+6',}},
		neck="Baetyl Pendant",
		waist="Embla Sash",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Weather. Ring",
		right_ring="Prolix Ring",
		back="Taranus's Cape",
	}

    sets.midcast.Cure = {
		ammo="Impatiens",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Vanya Robe", augments={'MP+49','"Cure" potency +7%','Enmity-5',}},
		hands={ name="Telchine Gloves", augments={'"Elemental Siphon"+30',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck="Voltsurge Torque",
		waist="Embla Sash",
		left_ear="Mendi. Earring",
		right_ear="Loquac. Earring",
		left_ring="Sirona's Ring",
		right_ring="Ephedra Ring",
		back="Solemnity Cape",
	}
		
    sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {})
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {})

    sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	sets.midcast['Enhancing Magic'] = {
		ammo="Ghastly Tathlum +1",
		head="Umuthi Hat",
		body={ name="Telchine Chas.", augments={'Mag. Evasion+4','"Cure" spellcasting time -6%','Enh. Mag. eff. dur. +8',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Telchine Braconi", augments={'"Mag.Atk.Bns."+10','"Elemental Siphon"+35','Enh. Mag. eff. dur. +9',}},
		feet={ name="Merlinic Crackows", augments={'Accuracy+3','Crit.hit rate+2','Phalanx +2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		neck="Incanter's Torque",
		waist="Embla Sash",
		left_ear="Malignance Earring",
		right_ear="Andoaa Earring",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
	}
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.midcast['Enfeebling Magic'] = {    
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Erra Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Gwati Earring",
		left_ring="Weather. Ring",
		right_ring="Kishar Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
	}
		
    sets.midcast['Enfeebling Magic'].Resistant = {    
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Erra Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Gwati Earring",
		left_ring="Weather. Ring",
		right_ring="Kishar Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
	}
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {ear1="Malignance Earring",waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {ear1="Malignance Earring",waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

    sets.midcast['Dark Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {})

    sets.midcast.Drain = set_combine(sets.midcast['Enfeebling Magic'], {})
    
    sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast.Aspir.Death = {main=gear.grioavolr_nuke_staff,sub="Enki Strap",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Malignance Earring",ear2="Regal Earring",
        body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Evanescence Ring",ring2="Archon Ring",
        back=gear.nuke_jse_back,waist="Fucho-no-obi",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}
	
	sets.midcast.Death = {main=gear.grioavolr_nuke_staff,sub="Enki Strap",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Mizu. Kubikazari",ear1="Malignance Earring",ear2="Etiolation Earring",
        body=gear.merlinic_nuke_body,hands="Amalric Gages +1",ring1="Mujin Band",ring2="Archon Ring",
        back=gear.nuke_jse_back,waist=gear.ElementalObi,legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

    sets.midcast.Stun = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
        head="Amalric Coif +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Malignance Earring",
        body="Zendik Robe",hands="Volte Gloves",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
    sets.midcast.Stun.Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
        head="Amalric Coif +1",neck="Erra Pendant",ear1="Malignance Earring",ear2="Regal Earring",
        body="Zendik Robe",hands="Volte Gloves",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist="Witful Belt",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}

    sets.midcast.BardSong = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
        head="Amalric Coif +1",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Regal Earring",
        body="Zendik Robe",hands="Regal Cuffs",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist="Luminary Sash",legs="Merlinic Shalwar",feet="Medium's Sabots"}
		
	sets.midcast.Impact = {main="Daybreak",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head=empty,neck="Erra Pendant",ear1="Malignance Earring",ear2="Regal Earring",
		body="Twilight Cloak",hands="Regal Cuffs",ring1="Stikini Ring +1",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}
		
    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Src. Stole +1",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Barkaro. Earring",
		left_ring="Strendu Ring",
		right_ring="Acumen Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
	}
		
    sets.midcast['Elemental Magic'].Resistant = {
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Src. Stole +1",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Barkaro. Earring",
		left_ring="Strendu Ring",
		right_ring="Acumen Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
	}
		
    sets.midcast['Elemental Magic'].Fodder = {
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Src. Stole +1",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Barkaro. Earring",
		left_ring="Strendu Ring",
		right_ring="Acumen Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
	}

	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {})
	
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant
		
		-- Minimal damage gear, maximum recast gear for procs.
    sets.midcast['Elemental Magic'].Proc = {
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +9','CHR+5','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','Mag. Acc.+3',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','Mag. Acc.+10','"Mag.Atk.Bns."+11',}},
		neck="Src. Stole +1",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Barkaro. Earring",
		left_ring="Strendu Ring",
		right_ring="Acumen Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
	}
		
    sets.midcast['Elemental Magic'].OccultAcumen = {}
		
    sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {head=empty,body="Twilight Cloak"})
	
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Rng.Atk.+4','Pet: DEX+14','"Refresh"+2',}},
		body="Mallquis Saio +2",
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Spell interruption rate down -7%','Pet: VIT+3','"Refresh"+2',}},
		feet="Wicce Sabots +1",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Evans Earring",
		right_ear="Barkaro. Earring",
		left_ring="Defending Ring",
		right_ring="Mephitas's Ring +1",
		back="Moonbeam Cape",
	}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Rng.Atk.+4','Pet: DEX+14','"Refresh"+2',}},
		body="Mallquis Saio +2",
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Spell interruption rate down -7%','Pet: VIT+3','"Refresh"+2',}},
		feet="Wicce Sabots +1",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Evans Earring",
		right_ear="Barkaro. Earring",
		left_ring="Defending Ring",
		right_ring="Mephitas's Ring +1",
		back="Moonbeam Cape",
	}
		
	sets.idle.DTHippo = set_combine(sets.idle.PDT, {})

	sets.idle.Death = {
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Rng.Atk.+4','Pet: DEX+14','"Refresh"+2',}},
		body="Mallquis Saio +2",
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Spell interruption rate down -7%','Pet: VIT+3','"Refresh"+2',}},
		feet="Wicce Sabots +1",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Evans Earring",
		right_ear="Barkaro. Earring",
		left_ring="Defending Ring",
		right_ring="Mephitas's Ring +1",
		back="Moonbeam Cape",
	}

    sets.idle.Weak = {
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Rng.Atk.+4','Pet: DEX+14','"Refresh"+2',}},
		body="Mallquis Saio +2",
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Spell interruption rate down -7%','Pet: VIT+3','"Refresh"+2',}},
		feet="Wicce Sabots +1",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Evans Earring",
		right_ear="Barkaro. Earring",
		left_ring="Defending Ring",
		right_ring="Mephitas's Ring +1",
		back="Moonbeam Cape",
	}

    -- Defense sets

    sets.defense.PDT = {
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Rng.Atk.+4','Pet: DEX+14','"Refresh"+2',}},
		body="Mallquis Saio +2",
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Spell interruption rate down -7%','Pet: VIT+3','"Refresh"+2',}},
		feet="Wicce Sabots +1",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Evans Earring",
		right_ear="Barkaro. Earring",
		left_ring="Defending Ring",
		right_ring="Mephitas's Ring +1",
		back="Moonbeam Cape",
	}
    sets.defense.MDT = {
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Rng.Atk.+4','Pet: DEX+14','"Refresh"+2',}},
		body="Mallquis Saio +2",
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Spell interruption rate down -7%','Pet: VIT+3','"Refresh"+2',}},
		feet="Wicce Sabots +1",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Evans Earring",
		right_ear="Barkaro. Earring",
		left_ring="Defending Ring",
		right_ring="Mephitas's Ring +1",
		back="Moonbeam Cape",
	}
		
    sets.defense.MEVA = {
		ammo="Ghastly Tathlum +1",
		head={ name="Merlinic Hood", augments={'Rng.Atk.+4','Pet: DEX+14','"Refresh"+2',}},
		body="Mallquis Saio +2",
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Spell interruption rate down -7%','Pet: VIT+3','"Refresh"+2',}},
		feet="Wicce Sabots +1",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Sacro Cord",
		left_ear="Evans Earring",
		right_ear="Barkaro. Earring",
		left_ring="Defending Ring",
		right_ring="Mephitas's Ring +1",
		back="Moonbeam Cape",
	}

	sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}
	sets.DayIdle = {feet=gear.merlinic_refresh_feet}
	sets.NightIdle = {}
	
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	
	sets.HPDown = {}
		
	sets.HPCure = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff['Mana Wall'] = {
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
		feet="Wicce Sabots +1"
	}
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Spaekona's Coat +3"}
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {}
	sets.ResistantMagicBurst = {}
	
	-- Gear for specific elemental nukes.
	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Staunch Tathlum +1",
        head="Jhakri Coronal +2",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back=gear.stp_jse_back,waist="Olseni Belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"}
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 8)
end