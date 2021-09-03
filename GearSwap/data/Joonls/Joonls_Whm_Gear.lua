-- Setup vars that are user-dependent.  Can override this in a sidecar file.
function user_job_setup()
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant')
    state.IdleMode:options('Normal','PDT')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','DualWeapons','MeleeWeapons')

		-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	send_command('bind !` input /ja "Penury" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurora Storm" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind !backspace input /ja "Accession" <me>')
	send_command('bind != input /ja "Sublimation" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

	-- Weapons sets
	sets.weapons = {}
	sets.weapons.MeleeWeapons = {main="Maxentius", sub="Ammurapi Shield"}
	sets.weapons.DualWeapons = {main="Maxentius", sub="Izcalli"}
	
    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Impatiens",
		head="Nahtirah Hat",
		body="Inyanga Jubbah +2",
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%',}},
		legs="Aya. Cosciales +2",
		feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back={ name="Fi Follet Cape +1", augments={'Path: A',}},
	}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pant. +1"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
	
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {feet="Hygieia Clogs +1"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Ammurapi Shield"})

    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Aya. Cosciales +2",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Brutal Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Rajas Ring",
		back={ name="Fi Follet Cape +1", augments={'Path: A',}},
	}
		
    sets.precast.WS.Dagan = {}
		
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring"}
	sets.MaxTP.Dagan = {ear1="Etiolation Earring",ear2="Evans Earring"}

    --sets.precast.WS['Flash Nova'] = {}

    --sets.precast.WS['Mystic Boon'] = {}

    -- Midcast Sets

    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {
		head="Wh. Rarab Cap +1",
		hands={ name="Chironic Gloves", augments={'Sklchn.dmg.+3%','STR+4','"Treasure Hunter"+2',}},
		waist="Chaac Belt",
	})
	
	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}

	-- Conserve Mp set for spells that don't need anything else, for set_combine.
	
	sets.ConserveMP = {}
		
	sets.midcast.Teleport = sets.ConserveMP
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {
		neck="Mizu. Kubikazari",
	}
	
    sets.midcast.FastRecast = {
		ammo="Impatiens",
		head="Nahtirah Hat",
		body="Inyanga Jubbah +2",
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%',}},
		legs="Aya. Cosciales +2",
		feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back={ name="Fi Follet Cape +1", augments={'Path: A',}},
	}
		
    -- Cure sets

	sets.midcast['Full Cure'] = sets.midcast.FastRecast

	sets.midcast.Cure = {
		main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
		sub="Sors Shield",
		ammo="Impatiens",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Vanya Robe", augments={'MP+49','"Cure" potency +7%','Enmity-5',}},
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%',}},
		legs="Ebers Pantaloons",
		feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
		neck="Incanter's Torque",
		waist="Witful Belt",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Sirona's Ring",
		right_ring="Ephedra Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}
		
	sets.midcast.CureSolace = {
		main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
		sub="Sors Shield",
		ammo="Impatiens",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Vanya Robe", augments={'MP+49','"Cure" potency +7%','Enmity-5',}},
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%',}},
		legs="Ebers Pantaloons",
		feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
		neck="Incanter's Torque",
		waist="Witful Belt",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Sirona's Ring",
		right_ring="Ephedra Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

	sets.midcast.LightWeatherCure = {
		main="Chatoyant Staff",
		ammo="Homiliary",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Vanya Robe", augments={'MP+49','"Cure" potency +7%','Enmity-5',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
		neck="Incanter's Torque",
		waist="Witful Belt",
		left_ear="Malignance Earring",
		right_ear="Mendi. Earring",
		left_ring="Sirona's Ring",
		right_ring="Ephedra Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

	sets.midcast.LightWeatherCureSolace = {
		main="Chatoyant Staff",
		ammo="Homiliary",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Vanya Robe", augments={'MP+49','"Cure" potency +7%','Enmity-5',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
		neck="Incanter's Torque",
		waist="Witful Belt",
		left_ear="Malignance Earring",
		right_ear="Mendi. Earring",
		left_ring="Sirona's Ring",
		right_ring="Ephedra Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}
		
	sets.midcast.LightDayCureSolace = {
		main="Chatoyant Staff",
		ammo="Homiliary",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Vanya Robe", augments={'MP+49','"Cure" potency +7%','Enmity-5',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
		neck="Incanter's Torque",
		waist="Witful Belt",
		left_ear="Malignance Earring",
		right_ear="Mendi. Earring",
		left_ring="Sirona's Ring",
		right_ring="Ephedra Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

	sets.midcast.LightDayCure = {
		main="Chatoyant Staff",
		ammo="Homiliary",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Vanya Robe", augments={'MP+49','"Cure" potency +7%','Enmity-5',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		feet={ name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}},
		neck="Incanter's Torque",
		waist="Witful Belt",
		left_ear="Malignance Earring",
		right_ear="Mendi. Earring",
		left_ring="Sirona's Ring",
		right_ring="Ephedra Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

	sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})
		
	sets.midcast.LightWeatherCuraga = set_combine(sets.midcast.LightWeatherCure, {})
		
	sets.midcast.LightDayCuraga = set_combine(sets.midcast.LightWeatherCuraga, {})

	sets.midcast.Cure.DT = set_combine(sets.midcast.Cure, {})
		
	--Melee Curesets are used whenever your Weapons state is set to anything but None.
	sets.midcast.MeleeCure = set_combine(sets.midcast.Cure, {})
		
	sets.midcast.MeleeCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1"})
	sets.midcast.MeleeLightWeatherCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace = set_combine(sets.midcast.MeleeCure, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga = set_combine(sets.midcast.MeleeCure, {})
	sets.midcast.MeleeLightWeatherCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga = set_combine(sets.midcast.MeleeCure, {waist="Hachirin-no-Obi"})

	sets.midcast.CureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1"})
	sets.midcast.LightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.Curaga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.LightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.LightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCure.DT = set_combine(sets.midcast.Cure.DT, {})
	
	sets.midcast.MeleeCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1"})
	sets.midcast.MeleeLightWeatherCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightWeatherCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCureSolace.DT = set_combine(sets.midcast.Cure.DT, {body="Ebers Bliaud +1",waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCure.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeCuraga.DT = set_combine(sets.midcast.Cure.DT, {})
	sets.midcast.MeleeLightWeatherCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})
	sets.midcast.MeleeLightDayCuraga.DT = set_combine(sets.midcast.Cure.DT, {waist="Hachirin-no-Obi"})

	sets.midcast.Cursna = {
		ammo="Homiliary",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Vanya Robe", augments={'MP+49','"Cure" potency +7%','Enmity-5',}},
		hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +8','"Conserve MP"+5','"Fast Cast"+5',}},
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck="Incanter's Torque",
		waist="Witful Belt",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Sirona's Ring",
		right_ring="Ephedra Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

	sets.midcast.StatusRemoval = {
		ammo="Homiliary",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Vanya Robe", augments={'MP+49','"Cure" potency +7%','Enmity-5',}},
		hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +8','"Conserve MP"+5','"Fast Cast"+5',}},
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck="Incanter's Torque",
		waist="Witful Belt",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Sirona's Ring",
		right_ring="Ephedra Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}
		
	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Cleric's Torque"})

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] = {
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','MND+5','Mag. Acc.+6','"Mag.Atk.Bns."+4',}},
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head="Umuthi Hat",
		body={ name="Telchine Chas.", augments={'Mag. Evasion+4','"Cure" spellcasting time -6%','Enh. Mag. eff. dur. +8',}},
		hands="Inyan. Dastanas +1",
		legs={ name="Telchine Braconi", augments={'"Mag.Atk.Bns."+10','"Elemental Siphon"+35','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Evasion+2','"Elemental Siphon"+35','Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
		waist="Cascade Belt",
		left_ear="Malignance Earring",
		right_ear="Andoaa Earring",
		left_ring="Stikini Ring",
		right_ring="Kishar Ring",
		back={ name="Fi Follet Cape +1", augments={'Path: A',}},
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})

	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {feet="Ebers Duckbills +1"})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Ammurapi Shield",hands="Regal Cuffs",waist="Emphatikos Rope",legs="Shedir Seraweels"})

	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head="Inyanga Tiara +2"})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",feet="Piety Duckbills +1",ear1="Gifted Earring",waist="Sekhmet Corset"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",feet="Piety Duckbills +1",ear1="Gifted Earring",waist="Sekhmet Corset"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",legs="Piety Pantaln. +1",ear1="Gifted Earring",waist="Sekhmet Corset"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",legs="Piety Pantaln. +1",ear1="Gifted Earring",waist="Sekhmet Corset"})
	
	sets.midcast.BarElement = {
		main="Beneficus",
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head="Umuthi Hat",
		body={ name="Telchine Chas.", augments={'Mag. Evasion+4','"Cure" spellcasting time -6%','Enh. Mag. eff. dur. +8',}},
		hands="Inyan. Dastanas +1",
		legs={ name="Telchine Braconi", augments={'"Mag.Atk.Bns."+10','"Elemental Siphon"+35','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Evasion+2','"Elemental Siphon"+35','Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
		waist="Cascade Belt",
		left_ear="Malignance Earring",
		right_ear="Andoaa Earring",
		left_ring="Stikini Ring",
		right_ring="Kishar Ring",
		back={ name="Fi Follet Cape +1", augments={'Path: A',}},
	}

	sets.midcast.Impact = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		head=empty,
		body="Twilight Cloak",
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}
		
	sets.midcast['Elemental Magic'] = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

	sets.midcast['Elemental Magic'].Resistant = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

	sets.midcast['Divine Magic'] = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}
		
	sets.midcast.Holy = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Weather. Ring",
		right_ring="Strendu Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

	sets.midcast['Dark Magic'] = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

    sets.midcast.Drain = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

    sets.midcast.Drain.Resistant = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

	sets.midcast.Stun.Resistant = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}
		
	sets.midcast.Dispel = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}
		
	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {main="Daybreak",sub="Ammurapi Shield"})

	sets.midcast['Enfeebling Magic'] = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

	sets.midcast['Enfeebling Magic'].Resistant = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Cure" potency +5%','MND+11','Mag. Acc.+11',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+10','Mag. Acc.+11',}},
		feet="Nyame Sollerets",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		left_ring="Acumen Ring",
		right_ring="Strendu Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {back="Alaunus's Cape"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {back="Alaunus's Cape"})

    -- Sets to return to when not performing an action.

    -- Resting sets
	sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		main="Bolelabunga",
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Twilight Torque",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Strendu Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

	sets.idle.PDT = set_combine(sets.idle, {})
		
	sets.idle.MDT = set_combine(sets.idle, {})
		
	sets.idle.Weak = set_combine(sets.idle, {})

    -- Defense sets

	sets.defense.PDT = set_combine(sets.idle, {})

	sets.defense.MDT = set_combine(sets.idle, {})

    sets.defense.MEVA = set_combine(sets.idle, {})
		
		-- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Nyame Sollerets",
		neck="Clotharius Torque",
		waist="Eschan Stone",
		left_ear="Brutal Earring",
		right_ear="Crep. Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

    sets.engaged.Acc = {
		main="Maxentius",
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Nyame Sollerets",
		neck="Clotharius Torque",
		waist="Eschan Stone",
		left_ear="Brutal Earring",
		right_ear="Crep. Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

	sets.engaged.DW = {
		main="Maxentius",
		sub="Izcalli",
		ammo="Homiliary",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Nyame Sollerets",
		neck="Clotharius Torque",
		waist="Eschan Stone",
		left_ear="Brutal Earring",
		right_ear="Crep. Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

    sets.engaged.DW.Acc = {
		main="Maxentius",
		sub="Izcalli",
		ammo="Homiliary",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Nyame Sollerets",
		neck="Clotharius Torque",
		waist="Eschan Stone",
		left_ear="Brutal Earring",
		right_ear="Crep. Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Occ. inc. resist. to stat. ailments+10',}},
	}

		-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {}

	sets.HPDown = {}

	sets.HPCure = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 13)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 015') --Catchall just in case something's weird.
end