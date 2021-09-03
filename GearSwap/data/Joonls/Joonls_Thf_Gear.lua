-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal','DT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder','Proc')
	state.IdleMode:options('Normal', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Evisceration','Bow','Punch')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWMax','Parry'}
	state.AmbushMode = M(false, 'Ambush Mode')

	gear.da_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	gear.wsd_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind !` input /ra <t>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f10 gs c toggle AmbushMode')
	send_command('bind ^backspace input /item "Thief\'s Tools" <t>')
	send_command('bind ^q gs c weapons ProcWeapons;gs c set WeaponSkillMode proc;')
	send_command('bind !q gs c weapons SwordThrowing')
	send_command('bind !backspace input /ja "Hide" <me>')
	send_command('bind ^r gs c weapons Default;gs c set WeaponSkillMode match') --Requips weapons and gear.
	send_command('bind !t gs c weapons MagicWeapons')
	send_command('bind ^\\\\ input /ja "Despoil" <t>')
	send_command('bind !\\\\ input /ja "Mug" <t>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

	sets.TreasureHunter = {
		head={ name="Herculean Helm", augments={'"Fast Cast"+2','"Drain" and "Aspir" potency +1','"Treasure Hunter"+2','Accuracy+10 Attack+10','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
		body={ name="Herculean Vest", augments={'"Drain" and "Aspir" potency +7','"Store TP"+3','"Treasure Hunter"+2',}},
		hands={ name="Plun. Armlets +1", augments={'Enhances "Perfect Dodge" effect',}},
		legs={ name="Herculean Trousers", augments={'Enmity+1','"Blood Pact" ability delay -2','"Treasure Hunter"+1',}},
		feet="Skulk. Poulaines +1",
		waist="Chaac Belt",
	}
    sets.ExtraRegen = {}
    sets.Kiting = {feet="Fajin boots"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	
    sets.buff['Sneak Attack'] = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body={ name="Herculean Vest", augments={'"Snapshot"+4','DEX+6','Quadruple Attack +3','Accuracy+16 Attack+16','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','Accuracy+8',}},
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Lissome Necklace",
		waist="Windbuffet Belt",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back="Sokolski Mantle",
	}

    sets.buff['Trick Attack'] = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body={ name="Herculean Vest", augments={'"Snapshot"+4','DEX+6','Quadruple Attack +3','Accuracy+16 Attack+16','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','Accuracy+8',}},
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Lissome Necklace",
		waist="Windbuffet Belt",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back="Sokolski Mantle",
	}

    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.Suppa = {ear1="Suppanomimi", ear2="Sherida Earring"}
	sets.DWEarrings = {}
	sets.DWMax = {}
	sets.Parry = {hands="Turms Mittens +1",ring1="Defending Ring"}
	sets.Ambush = {} --body="Plunderer's Vest +1"
	
	-- Weapons sets
	sets.weapons.Evisceration = {main="Tauret",sub="Taming Sari"}
	sets.weapons.Bow = {main="Tauret",sub="Taming Sari",range="Kaja Bow",ammo="Chapuli Arrow"}
	sets.weapons.Punch = {main="Karambit"}
	
    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.JA['Violent Flourish'] = sets.TreasureHunter
	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {"Skulker's Bonnet"}
    sets.precast.JA['Accomplice'] = {"Skulker's Bonnet"}
    sets.precast.JA['Flee'] = {} --feet="Pillager's Poulaines +1"
    sets.precast.JA['Hide'] = {body="Pillager's Vest +1"}
    sets.precast.JA['Conspirator'] = {body="Skulker's Vest"} 
    sets.precast.JA['Steal'] = {hands="Pill. Armlets +1"}
	sets.precast.JA['Mug'] = {}
    sets.precast.JA['Despoil'] = {legs="Skulker's Culottes",feet="Skulk. Poulaines +1"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Yamarang",
        head="Mummu Bonnet +2",neck="Unmoving Collar +1",ear1="Enchntr. Earring +1",ear2="Handler's Earring +1",
        body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
        back="Moonlight Cape",waist="Chaac Belt",legs="Dashing Subligar",feet=gear.herculean_waltz_feet}

	sets.Self_Waltz = {head="Mummu Bonnet +2",body="Passion Jacket",ring1="Asklepian Ring"}
		
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {ammo="Impatiens",
		head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Dread Jupon",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
		legs="Rawhide Trousers"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


    -- Ranged snapshot gear
    sets.precast.RA = {}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Falcon Eye",
		head="Malignance Chapeau",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs={ name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','Accuracy+8',}},
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back="Vell. Mantle +1",
	}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Honed Tathlum", back="Letalis Mantle"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {})
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {})
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {})
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {})

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {ammo="Honed Tathlum", back="Letalis Mantle"})
    sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {waist=gear.ElementalBelt})
    sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Qirmiz Tathlum"})
    sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Qirmiz Tathlum"})
    sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {ammo="Qirmiz Tathlum"})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mod, {})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mod, {})

    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {ear2="Moonshade Earring"})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Honed Tathlum", back="Letalis Mantle"})
    sets.precast.WS["Rudra's Storm"].Mod = set_combine(sets.precast.WS["Rudra's Storm"], {back="Kayapa Cape",waist=gear.ElementalBelt})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +1",legs="Pillager's Culottes +1"})

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {head="Pillager's Bonnet +1",ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {ammo="Honed Tathlum", back="Letalis Mantle"})
    sets.precast.WS['Shark Bite'].Mod = set_combine(sets.precast.WS['Shark Bite'], {back="Kayapa Cape",waist=gear.ElementalBelt})
    sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
    sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
    sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +1",legs="Pillager's Culottes +1"})

    sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {head="Pillager's Bonnet +1",ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Mandalic Stab'].Acc = set_combine(sets.precast.WS['Mandalic Stab'], {ammo="Honed Tathlum", back="Letalis Mantle"})
    sets.precast.WS['Mandalic Stab'].Mod = set_combine(sets.precast.WS['Mandalic Stab'], {back="Kayapa Cape",waist=gear.ElementalBelt})
    sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
    sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +1",legs="Pillager's Culottes +1"})
    sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {ammo="Qirmiz Tathlum",
        body="Pillager's Vest +1",legs="Pillager's Culottes +1"})

    sets.precast.WS['Aeolian Edge'] = {    
		head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+21','Weapon skill damage +3%','MND+2','Mag. Acc.+5',}},
		body={ name="Herculean Vest", augments={'"Mag.Atk.Bns."+24','Weapon skill damage +2%','MND+6',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+29','Weapon skill damage +2%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet={ name="Herculean Boots", augments={'Attack+23','Weapon skill damage +4%','AGI+3',}},
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Weather. Ring",
		right_ring="Acumen Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	}

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
        back="Moonlight Cape",waist="Tempus Fugit",legs="Rawhide Trousers",feet="Malignance Boots"}

    -- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

    -- Ranged gear

    sets.midcast.RA = {
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.da_jse_back,waist="Chaac Belt",legs="Malignance Tights",feet="Malignance Boots"}

    sets.midcast.RA.Acc = {
        head="Malignance Chapeau",neck="Iskur Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Malignance Gloves",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.da_jse_back,waist="Chaac Belt",legs="Malignance Tights",feet="Malignance Boots"}

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
        ring1="Sheltered Ring",ring2="Paguroidea Ring"}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Malignance Boots",
		neck="Warder's Charm",
		waist="Flume Belt",
		left_ear="Static Earring",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back="Solemnity Cape",
	}

    sets.idle.Town = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Malignance Boots",
		neck="Warder's Charm",
		waist="Flume Belt",
		left_ear="Static Earring",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back="Solemnity Cape",
	}

    sets.idle.Weak = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Malignance Boots",
		neck="Warder's Charm",
		waist="Flume Belt",
		left_ear="Static Earring",
		right_ear="Hearty Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back="Solemnity Cape",
	}


    -- Defense sets

    sets.defense.Evasion = {    
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands={ name="Plun. Armlets +1", augments={'Enhances "Perfect Dodge" effect',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Spell interruption rate down -6%','"Mag.Atk.Bns."+5','Damage taken-3%','Accuracy+10 Attack+10','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
		neck="Twilight Torque",
		waist="Flume Belt",
		left_ear="Sherida Earring",
		right_ear="Suppanomimi",
		left_ring="Defending Ring",
		right_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -6%',}},
		back="Solemnity Cape",
	}

    sets.defense.PDT = {    
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands={ name="Plun. Armlets +1", augments={'Enhances "Perfect Dodge" effect',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Spell interruption rate down -6%','"Mag.Atk.Bns."+5','Damage taken-3%','Accuracy+10 Attack+10','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
		neck="Twilight Torque",
		waist="Flume Belt",
		left_ear="Sherida Earring",
		right_ear="Suppanomimi",
		left_ring="Defending Ring",
		right_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -6%',}},
		back="Solemnity Cape",
	}

    sets.defense.MDT = {    
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands={ name="Plun. Armlets +1", augments={'Enhances "Perfect Dodge" effect',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Spell interruption rate down -6%','"Mag.Atk.Bns."+5','Damage taken-3%','Accuracy+10 Attack+10','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
		neck="Twilight Torque",
		waist="Flume Belt",
		left_ear="Sherida Earring",
		right_ear="Suppanomimi",
		left_ring="Defending Ring",
		right_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -6%',}},
		back="Solemnity Cape",
	}


    --------------------------------------
    -- Melee sets  
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body={ name="Herculean Vest", augments={'"Snapshot"+4','DEX+6','Quadruple Attack +3','Accuracy+16 Attack+16','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','Accuracy+8',}},
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Clotharius Torque",
		waist="Eschan Stone",
		left_ear="Sherida Earring",
		right_ear="Suppanomimi",
		left_ring="Epona's Ring",
		right_ring="Petrov Ring",
		back={ name="Mecisto. Mantle", augments={'Cap. Point+32%','AGI+2','"Mag.Atk.Bns."+1','DEF+6',}},
	}
		
    sets.engaged.SomeAcc = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body={ name="Herculean Vest", augments={'"Snapshot"+4','DEX+6','Quadruple Attack +3','Accuracy+16 Attack+16','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','Accuracy+8',}},
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Clotharius Torque",
		waist="Eschan Stone",
		left_ear="Sherida Earring",
		right_ear="Suppanomimi",
		left_ring="Epona's Ring",
		right_ring="Petrov Ring",
		back={ name="Mecisto. Mantle", augments={'Cap. Point+32%','AGI+2','"Mag.Atk.Bns."+1','DEF+6',}},
	}
    
	sets.engaged.Acc = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body={ name="Herculean Vest", augments={'"Snapshot"+4','DEX+6','Quadruple Attack +3','Accuracy+16 Attack+16','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','Accuracy+8',}},
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Lissome Necklace",
		waist="Windbuffet Belt",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back="Sokolski Mantle",
	}
		
    sets.engaged.FullAcc = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body={ name="Herculean Vest", augments={'"Snapshot"+4','DEX+6','Quadruple Attack +3','Accuracy+16 Attack+16','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','Accuracy+8',}},
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Lissome Necklace",
		waist="Windbuffet Belt",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back="Sokolski Mantle",
	}

    sets.engaged.Fodder = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body={ name="Herculean Vest", augments={'"Snapshot"+4','DEX+6','Quadruple Attack +3','Accuracy+16 Attack+16','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','Accuracy+8',}},
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Lissome Necklace",
		waist="Windbuffet Belt",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back="Sokolski Mantle",
	}

    sets.engaged.DT = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','Accuracy+8',}},
		feet="Malignance Boots",
		neck="Twilight Torque",
		waist="Windbuffet Belt",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Defending Ring",
		right_ring={ name="Dark Ring", augments={'Enemy crit. hit rate -2','Magic dmg. taken -4%','Phys. dmg. taken -6%',}},
		back="Sokolski Mantle",
	}

    sets.engaged.SomeAcc.DT = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','Accuracy+8',}},
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Lissome Necklace",
		waist="Windbuffet Belt",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back="Sokolski Mantle",
	}
		
    sets.engaged.Acc.DT = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','Accuracy+8',}},
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Lissome Necklace",
		waist="Windbuffet Belt",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back="Sokolski Mantle",
	}

    sets.engaged.FullAcc.DT = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','Accuracy+8',}},
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Lissome Necklace",
		waist="Windbuffet Belt",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back="Sokolski Mantle",
	}
		
    sets.engaged.Fodder.DT = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','Accuracy+8',}},
		feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+3','AGI+4','Attack+1',}},
		neck="Lissome Necklace",
		waist="Windbuffet Belt",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back="Sokolski Mantle",
	}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(8, 5)
    elseif player.sub_job == 'WAR' then
        set_macro_page(7, 5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(10, 5)
    else
        set_macro_page(6, 5)
    end
end

--Job Specific Trust Override
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()

				if spell_recasts[993] < spell_latency and not have_trust("ArkEV") then
					windower.chat.input('/ma "AAEV" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[955] < spell_latency and not have_trust("Apururu") then
					windower.chat.input('/ma "Apururu (UC)" <me>')
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
				else
					return false
				end
			end
		end
	end
	return false
end