function user_job_setup()

    -- Options: Override default values	
	state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Tank','DDTank','BreathTank','Dawn','NoShellTank','Normal')
    state.WeaponskillMode:options('Match','Normal', 'Acc')
    state.CastingMode:options('Normal','SIRD')
	state.Passive:options('None','AbsorbMP')
    state.PhysicalDefenseMode:options('PDT','PDT_HP','Tank')
    state.MagicalDefenseMode:options('BDT','MDT_HP','AegisMDT','AegisNoShellMDT','OchainMDT','OchainNoShellMDT','MDT_Reraise')
	state.ResistDefenseMode:options('MEVA','MEVA_HP','Death','Charm')
	state.IdleMode:options('Normal','Tank','KiteTank','PDT','MDT','Refresh','Reraise')
	state.Weapons:options('None','Aegis','Ochain','StatusAegis','StatusOchain','AOEDagger')
	
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP','Twilight'}
	
	gear.fastcast_jse_back = {name="Rudianos's Mantle",augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}}
	gear.enmity_jse_back = {name="Rudianos's Mantle",augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10',}}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind ^backspace input /ja "Shield Bash" <t>')
	send_command('bind @backspace input /ja "Cover" <stpt>')
	send_command('bind !backspace input /ja "Sentinel" <me>')
	send_command('bind @= input /ja "Chivalry" <me>')
	send_command('bind != input /ja "Palisade" <me>')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^pause gs c toggle AutoRuneMode')
	send_command('bind @f8 gs c toggle AutoTankMode') -- Alt+F8
	send_command('bind @f10 gs c toggle TankAutoDefense') -- Ctrl+F8
	send_command('bind ^@!` gs c cycle SkillchainMode')
	
	send_command('bind ^w gs c cycle weapons')
	
    select_default_macro_book()
    update_defense_mode()
	
	
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
    sets.Enmity = {    
		ammo="Sapience Orb",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Sacro Gorget",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
    sets.Enmity.SIRD = {
		ammo="Impatiens",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Kubira Meikogai",
		hands="Regal Gauntlets",
		legs={ name="Founder's Hose", augments={'MND+2','Mag. Acc.+4','Breath dmg. taken -1%',}},
		feet={ name="Odyssean Greaves", augments={'Pet: Accuracy+10 Pet: Rng. Acc.+10','Mag. Acc.+18 "Mag.Atk.Bns."+18','Magic burst dmg.+12%',}},
		neck="Diemer Gorget",
		waist="Flume Belt",
		left_ear="Thureous Earring",
		right_ear="Knightly Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
    sets.Enmity.DT = {    
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'"Fast Cast"+3','Pet: VIT+5','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Kubira Meikogai",
		hands="Volte Moufles",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Creed Collar",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
    -- Precast sets to enhance JAs
    -- sets.precast.JA['Invincible'] = set_combine(sets.Enmity,{legs="Cab. Breeches +1"})
    -- sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity,{feet="Rev. Leggings +3"})
    -- sets.precast.JA['Sentinel'] = set_combine(sets.Enmity,{feet="Cab. Leggings +1"})
    -- sets.precast.JA['Rampart'] = set_combine(sets.Enmity,{}) --head="Valor Coronet" (Also Vit?)
    -- sets.precast.JA['Fealty'] = set_combine(sets.Enmity,{body="Cab. Surcoat +1"})
    -- sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity,{feet="Chev. Sabatons +1"})
    -- sets.precast.JA['Cover'] = set_combine(sets.Enmity, {body="Cab. Surcoat +1"}) --head="Rev. Coronet +1",
	
    -- sets.precast.JA['Invincible'].DT = set_combine(sets.Enmity.DT,{legs="Cab. Breeches +1"})
    -- sets.precast.JA['Holy Circle'].DT = set_combine(sets.Enmity.DT,{feet="Rev. Leggings +3"})
    -- sets.precast.JA['Sentinel'].DT = set_combine(sets.Enmity.DT,{feet="Cab. Leggings +1"})
    -- sets.precast.JA['Rampart'].DT = set_combine(sets.Enmity.DT,{}) --head="Valor Coronet" (Also Vit?)
    -- sets.precast.JA['Fealty'].DT = set_combine(sets.Enmity.DT,{body="Cab. Surcoat +1"})
    -- sets.precast.JA['Divine Emblem'].DT = set_combine(sets.Enmity.DT,{feet="Chev. Sabatons +1"})
    -- sets.precast.JA['Cover'].DT = set_combine(sets.Enmity.DT, {body="Cab. Surcoat +1"}) --head="Rev. Coronet +1",
	
	-- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity,{})
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity,{})
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity,{})
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity,{}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity,{})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity,{})
    sets.precast.JA['Cover'] = set_combine(sets.Enmity, {}) --head="Rev. Coronet +1",
	
    sets.precast.JA['Invincible'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['Holy Circle'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['Sentinel'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['Rampart'].DT = set_combine(sets.Enmity.DT,{}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['Divine Emblem'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['Cover'].DT = set_combine(sets.Enmity.DT, {}) --head="Rev. Coronet +1",
	
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {}

	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {})		
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	
	sets.precast.JA['Shield Bash'].DT = set_combine(sets.Enmity.DT, {})		
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Palisade'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Intervene'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {    
		ammo="Sapience Orb",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Sacro Gorget",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {    
		ammo="Sapience Orb",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Sacro Gorget",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
	sets.precast.JA['Violent Flourish'] = {}
		
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    -- Fast cast sets for spells
    
    sets.precast.FC = {    
		main="Malignance Sword",
		ammo="Impatiens",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Sacro Breastplate",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Voltsurge Torque",
		waist="Flume Belt",
		left_ear="Loquac. Earring",
		right_ear="Knightly Earring",
		left_ring="Defending Ring",
		right_ring="Weather. Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
    sets.precast.FC.DT = {    
		main="Malignance Sword",
		ammo="Impatiens",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Sacro Breastplate",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Voltsurge Torque",
		waist="Flume Belt",
		left_ear="Loquac. Earring",
		right_ear="Knightly Earring",
		left_ring="Defending Ring",
		right_ring="Weather. Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {neck="Diemer Gorget",ear1="Nourish. Earring"})
  
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {    
		ammo="Impatiens",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Fotia Gorget",
		waist="Prosilio Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
    sets.precast.WS.DT = {    
		ammo="Impatiens",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Fotia Gorget",
		waist="Prosilio Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}

    sets.precast.WS.Acc = {    
		ammo="Impatiens",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Fotia Gorget",
		waist="Prosilio Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",ear1="Mache Earring",ear2="Moonshade Earring"})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",ear1="Mache Earring",ear2="Moonshade Earring"})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {ear1="Mache Earring",ear2="Telos Earring"})
	
	sets.precast.WS['Flat Blade'] = {}

	sets.precast.WS['Flat Blade'].Acc = {}

    sets.precast.WS['Sanguine Blade'] = {	
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body="Sacro Breastplate",
		hands={ name="Odyssean Gauntlets", augments={'INT+11','"Mag.Atk.Bns."+25','Accuracy+10 Attack+10','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		legs={ name="Odyssean Cuisses", augments={'MND+7','Magic Damage +7','"Treasure Hunter"+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet={ name="Odyssean Greaves", augments={'Pet: Accuracy+10 Pet: Rng. Acc.+10','Mag. Acc.+18 "Mag.Atk.Bns."+18','Magic burst dmg.+12%',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}

	sets.precast.WS['Sanguine Blade'].Acc = sets.precast.WS['Sanguine Blade']

    sets.precast.WS['Atonement'] = {}

    sets.precast.WS['Atonement'].Acc = sets.precast.WS['Atonement']
    sets.precast.WS['Spirits Within'] = sets.precast.WS['Atonement']
    sets.precast.WS['Spirits Within'].Acc = sets.precast.WS['Atonement']

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}
	
	sets.precast.WS['Aeolian Edge'] = {	
		ammo="Ghastly Tathlum +1",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Sacro Breastplate",
		hands={ name="Odyssean Gauntlets", augments={'INT+11','"Mag.Atk.Bns."+25','Accuracy+10 Attack+10','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		legs={ name="Odyssean Cuisses", augments={'MND+7','Magic Damage +7','"Treasure Hunter"+1','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		feet={ name="Odyssean Greaves", augments={'Pet: Accuracy+10 Pet: Rng. Acc.+10','Mag. Acc.+18 "Mag.Atk.Bns."+18','Magic burst dmg.+12%',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
	    



	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = {    
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'"Fast Cast"+3','Pet: VIT+5','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Kubira Meikogai",
		hands="Volte Moufles",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Creed Collar",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
	sets.midcast.FastRecast.DT = {    
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'"Fast Cast"+3','Pet: VIT+5','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Kubira Meikogai",
		hands="Volte Moufles",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Creed Collar",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}

    sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Stun.SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Cure = {
		main={ name="Brilliance", augments={'Shield skill +10','Divine magic skill +15','Enmity+7','DMG:+15',}},
		ammo="Sapience Orb",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Sacro Gorget",
		waist="Asklepian Belt",
		left_ear="Nourish. Earring",
		right_ear="Mendi. Earring",
		left_ring="Defending Ring",
		right_ring="Weather. Ring",
		back="Solemnity Cape",
	}
		
    sets.midcast.Cure.SIRD = {
		main={ name="Brilliance", augments={'Shield skill +10','Divine magic skill +15','Enmity+7','DMG:+15',}},
		ammo="Sapience Orb",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Sacro Gorget",
		waist="Asklepian Belt",
		left_ear="Nourish. Earring",
		right_ear="Mendi. Earring",
		left_ring="Defending Ring",
		right_ring="Weather. Ring",
		back="Solemnity Cape",
	}
		
    sets.midcast.Cure.DT = {
		main={ name="Brilliance", augments={'Shield skill +10','Divine magic skill +15','Enmity+7','DMG:+15',}},
		ammo="Sapience Orb",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Sacro Gorget",
		waist="Asklepian Belt",
		left_ear="Nourish. Earring",
		right_ear="Mendi. Earring",
		left_ring="Defending Ring",
		right_ring="Weather. Ring",
		back="Solemnity Cape",
	}
		
    sets.midcast.Reprisal = {
		main={ name="Brilliance", augments={'Shield skill +10','Divine magic skill +15','Enmity+7','DMG:+15',}},
		ammo="Sapience Orb",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Sacro Gorget",
		waist="Asklepian Belt",
		left_ear="Nourish. Earring",
		right_ear="Mendi. Earring",
		left_ring="Defending Ring",
		right_ring="Weather. Ring",
		back="Solemnity Cape",
	}

	sets.Self_Healing = {
		main={ name="Brilliance", augments={'Shield skill +10','Divine magic skill +15','Enmity+7','DMG:+15',}},
		ammo="Sapience Orb",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Sacro Gorget",
		waist="Asklepian Belt",
		left_ear="Nourish. Earring",
		right_ear="Mendi. Earring",
		left_ring="Defending Ring",
		right_ring="Weather. Ring",
		back="Solemnity Cape",
	}
		
	sets.Self_Healing.SIRD = {
		main={ name="Brilliance", augments={'Shield skill +10','Divine magic skill +15','Enmity+7','DMG:+15',}},
		ammo="Sapience Orb",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Sacro Gorget",
		waist="Asklepian Belt",
		left_ear="Nourish. Earring",
		right_ear="Mendi. Earring",
		left_ring="Defending Ring",
		right_ring="Weather. Ring",
		back="Solemnity Cape",
	}
		
	sets.Self_Healing.DT = {
		main={ name="Brilliance", augments={'Shield skill +10','Divine magic skill +15','Enmity+7','DMG:+15',}},
		ammo="Sapience Orb",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Sacro Gorget",
		waist="Asklepian Belt",
		left_ear="Nourish. Earring",
		right_ear="Mendi. Earring",
		left_ring="Defending Ring",
		right_ring="Weather. Ring",
		back="Solemnity Cape",
	}

	sets.Cure_Received = {hands="Souv. Handsch. +1",feet="Souveran Schuhs +1"}
	sets.Self_Refresh = {}

    sets.midcast['Enhancing Magic'] = {
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Kubira Meikogai",
		hands="Regal Gauntlets",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Incanter's Torque",
		waist="Cascade Belt",
		left_ear="Andoaa Earring",
		right_ear="Knightly Earring",
		left_ring="Defending Ring",
		right_ring="Weather. Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
    sets.midcast['Enhancing Magic'].SIRD = {
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Kubira Meikogai",
		hands="Regal Gauntlets",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Incanter's Torque",
		waist="Cascade Belt",
		left_ear="Andoaa Earring",
		right_ear="Knightly Earring",
		left_ring="Defending Ring",
		right_ring="Weather. Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Incanter's Torque",
		waist="Cascade Belt",
		left_ear="Andoaa Earring",
	})
	sets.midcast.Phalanx.SIRD = set_combine(sets.midcast['Enhancing Magic'].SIRD, {
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Incanter's Torque",
		waist="Cascade Belt",
		left_ear="Andoaa Earring",
	})
	
	sets.midcast.Phalanx.DT = set_combine(sets.midcast.Phalanx.SIRD, {})	

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.resting = {    
		ammo="Sapience Orb",
		head={ name="Odyssean Helm", augments={'Accuracy+21 Attack+21','STR+8','Accuracy+12',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Sacro Gorget",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}

    -- Idle sets
    sets.idle = set_combine(sets.defense.MDT_HP)
		
    sets.idle.PDT = set_combine(sets.defense.PDT_HP)
		
    sets.idle.MDT = set_combine(sets.defense.MDT_HP)
		
	sets.idle.Refresh = set_combine(sets.defense.MDT_HP, {
		ammo="Homiliary",
		body="Chozor. Coselete",
		hands="Regal Gauntlets",
	})

	sets.idle.Tank = set_combine(sets.defense.MDT_HP)
		
	sets.idle.KiteTank = set_combine(sets.defense.MDT_HP)
		
    sets.idle.Reraise = set_combine(sets.defense.MDT_HP, {
		ead="Twilight Helm",
		body="Twilight Mail"
	})
		
    sets.idle.Weak = set_combine(sets.defense.MDT_HP)
	
	sets.idle.KiteTank = set_combine(sets.defense.MDT_HP)
		
	sets.Kiting = {legs="Carmine Cuisses +1"}

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {}
	sets.latent_regen = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
    sets.MP = {}
    sets.MP_Knockback = {}
    sets.Twilight = {head="Twilight Helm", body="Twilight Mail"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Aegis = {sub="Aegis"}
	sets.weapons.Ochain = {sub="Ochain"}
	sets.weapons.StatusAegis = {main="Malignance Sword",sub="Aegis"}
	sets.weapons.StatusOchain = {main="Malignance Sword",sub="Ochain"}
	sets.weapons.AOEDagger = {main="Malevolence",sub="Ochain"}
    
    sets.defense.PDT = {    
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'"Fast Cast"+3','Pet: VIT+5','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Creed Collar",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
    sets.defense.PDT_HP = {    
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'"Fast Cast"+3','Pet: VIT+5','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Creed Collar",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
    sets.defense.MDT_HP = {    
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'"Fast Cast"+3','Pet: VIT+5','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Creed Collar",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
    sets.defense.MEVA_HP = {    
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'"Fast Cast"+3','Pet: VIT+5','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Kubira Meikogai",
		hands="Volte Moufles",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Creed Collar",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
    sets.defense.PDT_Reraise = {    
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'"Fast Cast"+3','Pet: VIT+5','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Creed Collar",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
    sets.defense.MDT_Reraise = {    
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'"Fast Cast"+3','Pet: VIT+5','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Creed Collar",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}

	sets.defense.BDT = {    
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'"Fast Cast"+3','Pet: VIT+5','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Creed Collar",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
	sets.defense.Tank = {    
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'"Fast Cast"+3','Pet: VIT+5','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Creed Collar",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
	sets.defense.MEVA = {    
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'"Fast Cast"+3','Pet: VIT+5','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Kubira Meikogai",
		hands="Volte Moufles",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Creed Collar",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
	sets.defense.Death = {    
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'"Fast Cast"+3','Pet: VIT+5','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Creed Collar",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
	sets.defense.Charm = {    
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'"Fast Cast"+3','Pet: VIT+5','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Kubira Meikogai",
		hands="Volte Moufles",
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Creed Collar",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
		-- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.OchainMDT = {    
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'"Fast Cast"+3','Pet: VIT+5','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Creed Collar",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
    sets.defense.OchainNoShellMDT = {sub="Aegis"}
		
    sets.defense.AegisMDT = {    
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'"Fast Cast"+3','Pet: VIT+5','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Creed Collar",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
    sets.defense.AegisNoShellMDT = {    
		ammo="Homiliary",
		head={ name="Odyssean Helm", augments={'"Fast Cast"+3','Pet: VIT+5','Accuracy+15 Attack+15','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
		body="Kubira Meikogai",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Creed Collar",
		waist="Asklepian Belt",
		left_ear="Thureous Earring",
		right_ear="Trux Earring",
		left_ring="Defending Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}	

	--------------------------------------
	-- Engaged sets
	--------------------------------------
    
	sets.engaged = {    
		ammo="Homiliary",
		head="Sulevia's Mask +1",
		body="Kubira Meikogai",
		hands="Sulev. Gauntlets +2",
		legs="Sulevi. Cuisses +1",
		feet="Sulev. Leggings +2",
		neck="Lissome Necklace",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Dedition Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}

    sets.engaged.Acc = {    
		ammo="Homiliary",
		head="Sulevia's Mask +1",
		body="Kubira Meikogai",
		hands="Sulev. Gauntlets +2",
		legs="Sulevi. Cuisses +1",
		feet="Sulev. Leggings +2",
		neck="Lissome Necklace",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Dedition Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}

    sets.engaged.DW = {}

    sets.engaged.DW.Acc = {}

	sets.engaged.Tank = set_combine(sets.defense.PDT_HP, {})
		
	sets.engaged.Dawn = set_combine(sets.defense.PDT_HP, {})
		
	sets.engaged.BreathTank = set_combine(sets.defense.PDT_HP, {})
		
	sets.engaged.DDTank = {    
		ammo="Homiliary",
		head="Sulevia's Mask +1",
		body="Kubira Meikogai",
		hands="Sulev. Gauntlets +2",
		legs="Sulevi. Cuisses +1",
		feet="Sulev. Leggings +2",
		neck="Lissome Necklace",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Dedition Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
	sets.engaged.Acc.DDTank = {    
		ammo="Homiliary",
		head="Sulevia's Mask +1",
		body="Kubira Meikogai",
		hands="Sulev. Gauntlets +2",
		legs="Sulevi. Cuisses +1",
		feet="Sulev. Leggings +2",
		neck="Lissome Necklace",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Cessance Earring",
		right_ear="Dedition Earring",
		left_ring="Rajas Ring",
		right_ring="Petrov Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
	sets.engaged.NoShellTank = {}
		
    sets.engaged.Reraise = set_combine(sets.engaged.Tank, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc.Tank, sets.Reraise)
		
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Vim Torque +1"}
    -- sets.buff.Cover = {body="Cab. Surcoat +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'NIN' then
        set_macro_page(2, 9)
    elseif player.sub_job == 'RUN' then
        set_macro_page(9, 9)
    elseif player.sub_job == 'RDM' then
        set_macro_page(6, 9)
    elseif player.sub_job == 'BLU' then
        set_macro_page(8, 9)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 9)
    else
        set_macro_page(1, 9) --War/Etc
    end
end