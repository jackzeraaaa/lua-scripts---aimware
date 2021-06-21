-- referencias e coisas
ref = gui.Reference("Misc");
tab = gui.Tab(ref, "tab", "Extra");
box = gui.Groupbox(tab, "Anti-Aim", 20,20,200,0);
jackyaw = gui.Checkbox(box,"jackyaw","Jack Yaw", false);
inverter = gui.Keybox(box, "inverter", "Desync Inverter", 0);
doubletap = gui.Keybox(box, "doubletap", "Double Tap Key", 0);
damage = gui.Keybox(box, "damage", "Damage Override Key", 0);
mindmg = gui.Slider(box, "mindmg", "Minimum Damage Override", 1,1,100)

asnipercache = gui.GetValue("rbot.accuracy.weapon.asniper.mindmg")
snipercache = gui.GetValue("rbot.accuracy.weapon.sniper.mindmg")
hpistolcache = gui.GetValue("rbot.accuracy.weapon.hpistol.mindmg")
pistolcache = gui.GetValue("rbot.accuracy.weapon.pistol.mindmg")
smgcache = gui.GetValue("rbot.accuracy.weapon.smg.mindmg")
riflecache = gui.GetValue("rbot.accuracy.weapon.rifle.mindmg")
shotguncache = gui.GetValue("rbot.accuracy.weapon.shotgun.mindmg")
lmgcache = gui.GetValue("rbot.accuracy.weapon.lmg.mindmg")
scoutcache = gui.GetValue("rbot.accuracy.weapon.scout.mindmg")
local toggle = false;
local toggledt = false;
local toggledmg = false;
local posX,posY = draw.GetScreenSize();
posX = posX/2;
posY = posY/2;
fonte = draw.CreateFont("tahoma negrito",18);
if fonte == nil then 
	fonte = draw.CreateFont("tahoma bold",18);
end

-- engine radar do luizin pika
callbacks.Register("Draw", function()
	for index, Player in pairs(entities.FindByClass("CCSPlayer")) do
		Player:SetProp("m_bSpotted", 1);
	end
end)

-- get weapon in hand 
local function weapon()
	entity = entities.GetLocalPlayer()
	weaponID = entity:GetWeaponID()
	if weaponID==2 or weaponID==3 or weaponID==4 or weaponID==30 or weaponID==32 or weaponID==36 or weaponID==61 or weaponID==63 then
		return "pistol"
	elseif weaponID==9 then
		return "sniper"
	elseif weaponID==40 then
		return "scout"
	elseif weaponID==1 or weaponID==64 then
		return "hpistol"
	elseif weaponID==17 or weaponID== 19 or weaponID== 23 or weaponID== 24 or weaponID== 26 or weaponID== 33 or weaponID== 34 then
		return "smg"
	elseif weaponID==7 or weaponID==8 or weaponID== 10 or weaponID== 13 or weaponID== 16 or weaponID== 39 or weaponID== 61 then
		return "rifle"
	elseif weaponID== 25 or weaponID== 27 or weaponID== 29 or weaponID== 35 then
		return "shotgun"
	elseif weaponID == 38 or weaponID==11 then
		return "asniper"
	elseif weaponID == 28 or weaponID== 14 then
		return "lmg"
	end
end

-- inverter desync
callbacks.Register("Draw", function()
	if not jackyaw:GetValue() then return end
	if not entities.GetLocalPlayer() then return end
	draw.SetFont(fonte)
	draw.Color(255,183,0,255)
	local randomize = math.random(15,58)
	if toggle == false then
		gui.SetValue("rbot.antiaim.base.rotation", randomize)
		gui.SetValue("rbot.antiaim.base.lby", -116)
		draw.TextShadow(posX-draw.GetTextSize("LEFT")/2,posY+25, "LEFT")
	end
	if toggle == true then
		gui.SetValue("rbot.antiaim.base.rotation", -randomize)
		gui.SetValue("rbot.antiaim.base.lby", 116)
		draw.TextShadow(posX-draw.GetTextSize("RIGHT")/2,posY+25, "RIGHT")
	end
	if inverter:GetValue()==0 then return end
	if input.IsButtonPressed(inverter:GetValue()) and toggle == false then
		toggle = true;
		return
	end
	if input.IsButtonPressed(inverter:GetValue()) and toggle == true then
		toggle = false;
		return
	end
end)

-- doubletap toggle
callbacks.Register("Draw", function()
	if not entities.GetLocalPlayer() then return end
	if toggledt == false then
		gui.SetValue("rbot.accuracy.weapon.asniper.doublefire", 0)
		gui.SetValue("rbot.accuracy.weapon.sniper.doublefire", 0)
		gui.SetValue("rbot.accuracy.weapon.hpistol.doublefire", 0)
		gui.SetValue("rbot.accuracy.weapon.pistol.doublefire", 0)
		gui.SetValue("rbot.accuracy.weapon.smg.doublefire", 0)
		gui.SetValue("rbot.accuracy.weapon.rifle.doublefire", 0)
		gui.SetValue("rbot.accuracy.weapon.shotgun.doublefire", 0)
		gui.SetValue("rbot.accuracy.weapon.lmg.doublefire", 0)
		gui.SetValue("rbot.accuracy.weapon.scout.doublefire", 0)
		draw.Color(255,0,0,255)
	else
		gui.SetValue("rbot.accuracy.weapon.asniper.doublefire", 2)
		gui.SetValue("rbot.accuracy.weapon.sniper.doublefire", 2)
		gui.SetValue("rbot.accuracy.weapon.hpistol.doublefire", 2)
		gui.SetValue("rbot.accuracy.weapon.pistol.doublefire", 2)
		gui.SetValue("rbot.accuracy.weapon.smg.doublefire", 2)
		gui.SetValue("rbot.accuracy.weapon.rifle.doublefire", 2)
		gui.SetValue("rbot.accuracy.weapon.shotgun.doublefire", 2)
		gui.SetValue("rbot.accuracy.weapon.lmg.doublefire", 2)
		gui.SetValue("rbot.accuracy.weapon.scout.doublefire", 2)
		draw.Color(0,255,0,255)
	end
	if doubletap:GetValue()==0 then return end
	if input.IsButtonPressed(doubletap:GetValue()) and toggledt == false then
		toggledt = true;
	elseif input.IsButtonPressed(doubletap:GetValue()) and toggledt == true then
		toggledt = false;
	end
	draw.SetFont(fonte)
	draw.TextShadow(posX-draw.GetTextSize("DT")/2,posY+39, "DT")
end)

-- dmg override
callbacks.Register("Draw", function()
	if toggledmg == false then
		gui.SetValue("rbot.accuracy.weapon.asniper.mindmg", asnipercache)
		gui.SetValue("rbot.accuracy.weapon.sniper.mindmg", snipercache)
		gui.SetValue("rbot.accuracy.weapon.hpistol.mindmg", hpistolcache)
		gui.SetValue("rbot.accuracy.weapon.pistol.mindmg", pistolcache)
		gui.SetValue("rbot.accuracy.weapon.smg.mindmg", smgcache)
		gui.SetValue("rbot.accuracy.weapon.rifle.mindmg", riflecache)
		gui.SetValue("rbot.accuracy.weapon.shotgun.mindmg", shotguncache)
		gui.SetValue("rbot.accuracy.weapon.lmg.mindmg", lmgcache)
		gui.SetValue("rbot.accuracy.weapon.scout.mindmg", scoutcache)
	else
		gui.SetValue("rbot.accuracy.weapon.asniper.mindmg", mindmg:GetValue())
		gui.SetValue("rbot.accuracy.weapon.sniper.mindmg", mindmg:GetValue())
		gui.SetValue("rbot.accuracy.weapon.hpistol.mindmg", mindmg:GetValue())
		gui.SetValue("rbot.accuracy.weapon.pistol.mindmg", mindmg:GetValue())
		gui.SetValue("rbot.accuracy.weapon.smg.mindmg", mindmg:GetValue())
		gui.SetValue("rbot.accuracy.weapon.rifle.mindmg", mindmg:GetValue())
		gui.SetValue("rbot.accuracy.weapon.shotgun.mindmg", mindmg:GetValue())
		gui.SetValue("rbot.accuracy.weapon.lmg.mindmg", mindmg:GetValue())
		gui.SetValue("rbot.accuracy.weapon.scout.mindmg", mindmg:GetValue())
	end
	if damage:GetValue()==0 then return end
	if input.IsButtonPressed(damage:GetValue()) and toggledmg == false then
		toggledmg = true;
	elseif input.IsButtonPressed(damage:GetValue()) and toggledmg == true then
		toggledmg = false;
	end
	draw.SetFont(fonte)
	draw.Color(255,255,255,255)
	draw.TextShadow(posX-draw.GetTextSize(gui.GetValue("rbot.accuracy.weapon."..weapon()..".mindmg"))/2,posY+53, gui.GetValue("rbot.accuracy.weapon."..weapon()..".mindmg"))
end)
