g_TabControlHeight := g_TabControlHeight >= 700 ? g_TabControlHeight : 700
GUIFunctions.AddTab("AT-LJ")

g_SF := new IC_ATLJSharedFunctions_Class
global g_ATLJSettings := "" 

;Re Add these LJ
g_ATLJSettings.MaxMonsters := 75
g_ATLJSettings.MaxZone := 2000

Gui, ICScriptHub:Tab, AT-LJ
Gui, ICScriptHub:Font, w700
Gui, ICScriptHub:Add, Text, x15 y68 w120, What is happening:
Gui, ICScriptHub:Font, w400
Gui, ICScriptHub:Add, Text, x15 y+10 w300 vATLJStatus, This Addon is not running.
Gui, ICScriptHub:Add, Text, x15 y+5 w300 vATLJHew,
Gui, ICScriptHub:Add, Text, x15 y+5 w300 vATLJMonsters,
Gui, ICScriptHub:Add, Text, x15 y+5 w300 vATLJZone,
Gui, ICScriptHub:Add, Text, x15 y+5 w300 vATLJHaste,
Gui, ICScriptHub:Add, Text, x15 y+5 w300 vATLJFormation,
Gui, ICScriptHub:Add, Text, x15 y+5 w400 vATLJFkeys,
Gui, ICScriptHub:Add, Text, x15 y+5 w300 vATLJClick,
    

Gui, ICScriptHub:Font, w700
Gui, ICScriptHub:Add, Text, vATLJSettingsText x15 y+15 w120, Settings:
Gui, ICScriptHub:Font, w400

Gui, ICScriptHub:Add, Edit, vEbATLJConfigName gName_Changed x15 y+5 Limit40 w250 hwndConfigHandle,ATLJSettings
Gui, ICScriptHub:Add, Button, x+5 gATLJ_Save_Clicked, Save Settings

Gui, ICScriptHub:Add, Checkbox, vCbATLJLevelQ gLevelerCb x15 y+5,Q Formation
GUIFunctions.AddToolTip("CbATLJLevelQ", "Only level champions in the Q Formation")

Gui, ICScriptHub:Add, Checkbox, vCbATLJUseClick x+1, Click Damge
GUIFunctions.AddToolTip("CbATLJUseClick", "Level up the Click Damage")

Gui, ICScriptHub:Add, Text, x15 y+5, Slots:
Gui, ICScriptHub:Add, Text, x15 y+5, 
loop, 12
{
    Gui, ICScriptHub:Add, Checkbox, vCbATLJLevelSlot%A_Index% gLevelerCb x+1, % A_Index
    tmp = CbATLJLevelSlot%A_Index%
    tmp2 = Level up Champion in slot %A_Index%
    GUIFunctions.AddToolTip(tmp, tmp2)
}

Gui, ICScriptHub:Add, Text, x15 y+5, Ultimates:
Gui, ICScriptHub:Add, Text, x15 y+5,
loop, 10
{
    Gui, ICScriptHub:Add, Checkbox, vCbATLJUltimate%A_Index% x+1, % A_Index
    tmp = CbATLJUltimate%A_Index%
    tmp2 = Spam Ultimate Slot %A_Index%
    GUIFunctions.AddToolTip(tmp, tmp2)
}

Gui, ICScriptHub:Add, Checkbox, x15 y+15 vCbATLJUseHew, Check if Hew is alive

Gui, ICScriptHub:Add, Checkbox, vCbATLJUseBrivSkip x15 y+5, Briv - Skip Transition
Gui, ICScriptHub:Add, Checkbox, vCbATLJUseBrivW x+15, W Formation at end of run:

Gui, ICScriptHub:Add, Text, x15 y+15, Config type
Gui, ICScriptHub:Add, DropDownList, vLJConfig AltSubmit Choose4 x+15 gConfig_Type_Changed, Mod5|Mod10|Briv Jumps|Leveling Only|Config File|Code

GuicontrolGet, guiPos, Pos, LJConfig
guiPosY += 25
   
Gui, ICScriptHub:Add, Text,vM5 x15 y%guiPosY%, Mod 5:
loop, 5
    Gui, ICScriptHub:Add, Checkbox, 0x6 vCbATLJMod5Itm%A_Index%  x+5 gATLJ_CheckBox_Clicked, % A_Index

Gui, ICScriptHub:Add, Text, vM10 x15 y%guiPosY%, Mod 10:

loop, 10
    Gui, ICScriptHub:Add, Checkbox, 0x6 vCbATLJMod10Itm%A_Index% x+5 gATLJ_CheckBox_Clicked, % A_Index

Gui, ICScriptHub:Add, Text, vLoaderText1 x15 y%guiPosY% , Config 
Gui, ICScriptHub:Add, DDL, vLoadDDL x+5 w250 gLoadDDL_Changed, 
;Gui, ICScriptHub:Add, Button, vLoadButton x+5 gATLJLoad_Config, Load Config

Gui, ICScriptHub:Add, Text, vBrivText1 x15 y%guiPosY% , Briv skip
Gui, ICScriptHub:Add, DDL, vgBrivSkip x+5 w35 gBriv_Changed, 1|2|3|4|5|6|7|8|9
Gui, ICScriptHub:Add, Checkbox, vg100PercentBriv %g100PercentBriv% x+5 gBriv_Changed, 100`%
Gui, ICScriptHub:Add, Text, vBrivWarning x15 y+15 w400, Select your Briv

Gui, ICScriptHub:Add, Text, vZoneText x15 y+15, Zones: Key - 
Gui, ICScriptHub:add, CheckBox ,vCb1 gDontChangeMe Checked0 x+5,Q
Gui, ICScriptHub:add, CheckBox ,vCb2 0x6 gDontChangeMe Checked-1 x+5,W
Gui, ICScriptHub:add, CheckBox ,vCb3 gDontChangeMe Checked1 x+5,E
Gui, ICScriptHub:Add, Text, x2 y+5

loop, 50
{
    i := mod
    if (A_Index < 10)
        zoneText =0%A_Index%
    Else
        zoneText =%A_Index%
    if (mod(A_Index, 10) != 1 OR A_Index == 1)
        Gui, ICScriptHub:Add, Checkbox, 0x6 vCbATLJMod50Itm%A_Index% x+5 gATLJ_CheckBox_Clicked, %zoneText%
    else
        Gui, ICScriptHub:Add, Checkbox, 0x6 vCbATLJMod50Itm%A_Index% x15 y+5 gATLJ_CheckBox_Clicked, %zoneText%
}

Gui, ICScriptHub:add, button ,vButtonClear gClear_Clicked Checked1 x15 y+10, Clear Mod50
Gui, ICScriptHub:Add, Button, x15 y+15 w50 gATLJ_Run_Clicked, `Run
Gui, ICScriptHub:Add, Button, x+15 w50 gATLJ_Stop_Clicked, `Stop

global g_atlj := new ATLJ(g_ATLJSettings, true, ATLJ_GuiUpdater)

ATLJLoad_Config()
;Update_Mod50Cb()
Show_Config_Gui()

Return

Name_Changed:
{
	Gui, ICScriptHub:Submit, NoHide
    tmp := RegExReplace(EbATLJConfigName, "[^0-9a-zA-Z\-\_\ ]")
    if (EbATLJConfigNAme == tmp)
        return
    Guicontrol ICScriptHub:,EbATLJConfigName, %tmp%
    GuiControl, Focus, EbATLJConfigName
    SendMessage, 0xB1, -2, -1,, ahk_id %ConfigHandle%
    return
}

LevelerCb:
{
	Gui, ICScriptHub:Submit, NoHide
    if (A_GuiControl == "CbATLJLevelQ")
    {
        loop, 12
            GuiControl, ICScriptHub:, CbATLJLevelSlot%A_Index%, 0
    }
    Else
    {
        GuiControl, ICScriptHub:, CbATLJLevelQ,0
        g_ATLJSettings.LevelQ := ""
    }

    return
}

Check_Config()
{
    if ( g_ATLJSettings.UseClick == "" )
        g_ATLJSettings.UseClick := 1
    if ( g_ATLJSettings.LevelQ == "" )
        g_ATLJSettings.LevelQ := 1

    if ( g_ATLJSettings.LevelSlots == "")
        g_ATLJSettings.LevelSlots := 0
    if ( g_ATLJSettings.Ultimates == "")
        g_ATLJSettings.Ultimates := 0

    if ( g_ATLJSettings.UseHew == "" )
        g_ATLJSettings.UseHew := 0
    
    if ( g_ATLJSettings.UseBrivW == "" )
        g_ATLJSettings.UseBrivW := 0
    if ( g_ATLJSettings.UseBrivSkip == "" )
        g_ATLJSettings.UseBrivSkip := 0

    if ( g_ATLJSettings.ConfigType == "" )
        g_ATLJSettings.ConfigType := 4
    if ( g_ATLJSettings.Mod50 == "" )
        Clear_Clicked()
    return
}

Default_Config()
{
    g_ATLJSettings.UseClick := 1
    g_ATLJSettings.LevelQ := 1
    g_ATLJSettings.ConfigType := 4
    g_ATLJSettings.UseHew := 0
    g_ATLJSettings.UseBrivW := 0
    g_ATLJSettings.UseBrivSkip := 0
    g_ATLJSettings.LevelSlots := False
    g_ATLJSettings.Ultimates := False
    g_ATLJSettings.Mod50 := False

    Clear_Clicked()
    return
}

Clear_Clicked()
{
    Settings_Changed()
    g_ATLJSettings.Mod50 := {}
    loop, 50
        GuiControl, ICScriptHub:, CbATLJMod50Itm%A_Index%, 0

    loop, 5
        GuiControl, ICScriptHub:, CbATLJMod5Itm%A_Index%, 0

    loop, 10
        GuiControl, ICScriptHub:, CbATLJMod10Itm%A_Index%, 0

    return
}

Update_Mod50Cb()
{
    loop, 50
        CbMod50Itm%A_Index% := 0

    if (g_ATLJSettings.Mod50 == false)
        return

    for k, v in g_ATLJSettings.Mod50
    {
        if (v > 0)
       		GuiControl, ICScriptHub: , CbATLJMod50Itm%v% , 1
        else if (v < 0)
        {
            tmp := abs(v)
       		GuiControl, ICScriptHub: , CbATLJMod50Itm%tmp% , -1
        }
    }
    return
}

Update_LevelSlotsCb()
{
    loop, 12
        CbATLJLevelSlot%A_Index% := 0

    if (g_ATLJSettings.LevelSlots == false)
        return

    for k, v in g_ATLJSettings.LevelSlots
   		GuiControl, ICScriptHub: , CbATLJLevelSlot%v% , 1

    return
}

Update_UltimateSlotsCb()
{
    loop, 10
        CbATLJUltimate%A_Index% := 0

    if (g_ATLJSettings.Ultimates == false)
        return

    for k, v in g_ATLJSettings.Ultimates
   		GuiControl, ICScriptHub: , CbATLJUltimate%v% , 1

    return
}

Hide_Config_Gui()
{
    ;Mod5
    GuiControl, hide, M5
    Loop, 5
        GuiControl, hide, CbATLJMod5Itm%A_Index%

    ;Mod10
    GuiControl, hide, M10
    Loop, 10
        GuiControl, hide, CbATLJMod10Itm%A_Index%

    ;Briv jumps
    GuiControl, hide, BrivText1
    GuiControl, hide, gBrivSkip
    GuiControl, hide, g100PercentBriv
    GuiControl, hide, BrivWarning
    ;Config
    GuiControl, hide, LoaderText1
    GuiControl, hide, LoadDDL
    GuiControl, hide, LoadButton
    ;Code
    Loop, 50
        GuiControl, Hide, CbATLJMod50Itm%A_Index%
    GuiControl, Hide, ZoneText
    GuiControl, Hide, Cb1
    GuiControl, Hide, Cb2
    GuiControl, Hide, Cb3
    GuiControl, Hide, ButtonClear
    return
}

Config_Type_Changed:
{
	Gui, ICScriptHub:Submit, NoHide
    Settings_Changed()
    g_ATLJSettings.ConfigType := LJConfig
    Show_Config_Gui()
    return
}

Settings_Changed()
{
	Gui, Font, cRed Bold
    GuiControl ICSCriptHub:, ATLJSettingsText, Settings: Changed.
	GuiControl, Font, ATLJSettingsText
    return
}

Show_Config_Gui()
{ ;Mod5|Mod10|Briv Jumps|Leveling Only|Config File|Code
    Hide_Config_Gui()
    if (g_ATLJSettings.ConfigType == 1) ; Mod 5
    {
        GuiControl, show, M5
        Show_Mod50()
        Loop, 5
            GuiControl, show, CbATLJMod5Itm%A_Index%
    }
    else if (g_ATLJSettings.ConfigType == 2) ; Mod 10
    {
        GuiControl, show, M10
        Show_Mod50()
        Loop, 10
        GuiControl, show, CbATLJMod10Itm%A_Index%
    }
    else if (g_ATLJSettings.ConfigType == 3) ; Briv Jumps
    {
        Show_Mod50()
        GuiControl, show, BrivText1
        GuiControl, show, gBrivSkip
        GuiControl, show, g100PercentBriv
        GuiControl, show, BrivWarning
    }
    else if (g_ATLJSettings.ConfigType == 4) ; Leveling Only
    {

    }
    else if (g_ATLJSettings.ConfigType == 5) ; Config File
    {
        Build_ConfigDDL()
        GuiControl, show, LoaderText1
        GuiControl, show, LoadDDL
        GuiControl, show, LoadButton
    }
    else if (g_ATLJSettings.ConfigType == 6) ; Config Code
    {
        
    }
    return
}

Build_ConfigDDL()
{
    tmpList := "|"
    loop, Files, .\Addons\IC_ATLJ\Configs\*.JSon
    {
        tmp := SubStr(A_LoopFileName, 1, StrLen(A_LoopFileName) - 5)
        tmpList = %tmpList%%tmp%|
    }
    GuiControl, , LoadDDL, %tmpList%
    return
}

LoadDDL_Changed:
{
	Gui, ICScriptHub:Submit, NoHide
    GuiControl,,EbATLJConfigName,%LoadDDL%
    ATLJLoad_Config()
    return
}

ATLJLoad_Config()
{
    global
	Gui, ICScriptHub:Submit, NoHide
    ConfigName := EbATLJConfigName
    if (ConfigName = "")
        ConfigName = ATLJSetting
    ConfigName = `\..`\Configs`\%ConfigName%.Json
    g_ATLJSettings := g_SF.LoadObjectFromJSON( A_LineFile . ConfigName )
    If !IsObject( g_ATLJSettings )
    {
        g_ATLJSettings := {}
        Default_Config()
        g_SF.WriteObjectToJSON( A_LineFile . "\..\Configs\ATLJSettings.json" , g_ATLJSettings )
    }
    
    Check_Config()
    Check_Boxes()
    tmp := g_ATLJSettings.ConfigType
    GuiControl, Choose, LJConfig, %tmp%
	Gui, Font, cBlack Bold
    GuiControl ICSCriptHub:, ATLJSettingsText, Settings: Loaded.
	GuiControl, Font, ATLJSettingsText
    Show_Config_Gui()
    return
}

Check_Boxes()
{
    GUiControl, ICScriptHub:, CbATLJUseBrivW, 0
    GUiControl, ICScriptHub:, CbATLJUseBrivSkip, 0
    GUiControl, ICScriptHub:, CbATLJUseHew, 0
    GUiControl, ICScriptHub:, CbATLJUseClick, 0
    GUiControl, ICScriptHub:, CbATLJLevelQ, 0
    chk := g_ATLJSettings.UseBrivW
    GUiControl, ICScriptHub:, CbATLJUseBrivW, %chk%
    chk := g_ATLJSettings.UseBrivSkip
    GUiControl, ICScriptHub:, CbATLJUseBrivSkip, %chk%
    chk := g_ATLJSettings.UseHew
    GUiControl, ICScriptHub:, CbATLJUseHew, %chk%
    chk := g_ATLJSettings.UseClick
    GUiControl, ICScriptHub:, CbATLJUseClick, %chk%
    chk := g_ATLJSettings.LevelQ
    GUiControl, ICScriptHub:, CbATLJLevelQ, %chk%

    Update_LevelSlotsCb()
    Update_UltimateSlotsCb()
    Update_Mod50Cb()

    return
}
    

Show_Mod50()
{
    Loop, 50
        GuiControl, show, CbATLJMod50Itm%A_Index%
    GuiControl, Show, ZoneText
    GuiControl, Show, Cb1
    GuiControl, Show, Cb2
    GuiControl, Show, Cb3
    GuiControl, Show, ButtonClear
    return
}

DontChangeMe:
{
    GuiControl, ICScriptHub:, Cb1, 0
    GuiControl, ICScriptHub:, Cb2, -1
    GuiControl, ICScriptHub:, Cb3, 1
    return
}

Briv_Changed:
{
    Settings_Changed()
	Gui, ICScriptHub:Submit, NoHide

	skip := Mod(gBrivSkip, 5)

	zone := (4 - skip)
	Loop, 50
	{
		CbMod50Itm%A_Index% := 0
		GuiControl, ICScriptHub: , CbATLJMod50Itm%A_Index% , 0
		gZoneSkip[A_Index] := 0
			
		if ((Mod(A_Index, 5) = zone))
		{
			CbMod50Itm%A_Index% := 1
			GuiControl, ICScriptHub: , CbATLJMod50Itm%A_Index% , 1
			gZoneSkip[A_Index] := 1
		}
		if (not g100PercentBriv and (Mod(A_Index, 5) = zone+1) and not skip = 1)
		{
			CbMod50Itm%A_Index% := 1
			GuiControl, ICScriptHub: , CbATLJMod50Itm%A_Index% , 1
			gZoneSkip[A_Index] := 1
		}
	}

	Gui, Font
	GuiControl, , BrivWarning ,Selection Updated.
	GuiControl, Font, BrivWarning
	if (gBrivSkip = 5 or (gBrivSkip = 6 and not g100PercentBriv))
	{
		Gui, Font, cRed Bold
		GuiControl, , BrivWarning, Careful! You can land on bosses. 100`% 6 Skip recommended. GL!
		GuiControl, Font, BrivWarning
	}
	if ((gBrivSkip = 1) and not g100PercentBriv)
	{
		Gui, Font, cRed Bold
		GuiControl, , BrivWarning, You need at least 100`% 1 Skip Briv for ATLJ.
		GuiControl, Font, BrivWarning
	}
	Gui, ICScriptHub:Submit, NoHide

    ATLJ_CheckBoxToMod50()
	return
}

ATLJ_Run_Clicked() ;ConfigName := "ATLJSettings.json"
{
    GuiControl, ICScriptHub:, ATLJStatus, This Addon is currently running.
    g_jim.ATLJ()
    GuiControl, ICScriptHub:, ATLJStatus, % g_jim.EndRunTxt . " ATLJ run over."
    GuiControl, ICScriptHub:, ATLJHew,
    GuiControl, ICScriptHub:, ATLJMonsters,
    GuiControl, ICScriptHub:, ATLJZone,
    GuiControl, ICScriptHub:, ATLJHaste,
    GuiControl, ICScriptHub:, ATLJFormation,
    GuiControl, ICScriptHub:, ATLJFkeys,
    GuiControl, ICScriptHub:, ATLJClick,
    return
}

ATLJ_Stop_Clicked()
{
    return
}

ATLJ_Save_Clicked()
{
    global
    Gui, ICScriptHub:Submit, NoHide
    ConfigName := EbATLJConfigName
    if (ConfigName = "")
        ConfigName = ATLJSetting.Json

    g_ATLJSettings.LevelQ := CbATLJLevelQ
    g_ATLJSettings.UseHew := CbATLJUseHew
    g_ATLJSettings.UseBrivW := CbATLJUseBrivW
    g_ATLJSettings.UseBrivSkip := CbATLJUseBrivSkip
    g_ATLJSettings.UseClick := CbATLJUseClick


    ATLJ_CheckBoxToMod50()
    ATLJ_CheckBoxToLevelSlots()
    ATLJ_CheckBoxToUltimates()
    
    g_jim.UpdateSettings(g_ATLJSettings)
    FileName = `\..`\Configs`\%ConfigName%.Json
    g_SF.WriteObjectToJSON( A_LineFile . FileName , g_ATLJSettings )

	Gui, Font, cBlack Bold
    GuiControl ICSCriptHub:, ATLJSettingsText, Settings: Saved.
	GuiControl, Font, ATLJSettingsText
    return
}

ATLJ_CheckBox_Clicked()
{
    ;global
    Settings_Changed()
    Gui, ICScriptHub:Submit, NoHide

    chk := %A_GuiControl%
    FoundPos := InStr(A_GuiControl, "I")
    mod := SubStr(A_GuiControl, 10 , FoundPos - 10) + 0
    itm := SubStr(A_GuiControl, FoundPos + 3) + 0
    ;MsgBox, , Title, Chk %chk% Mod %mod% Itm %itm% %A_GuiControl%
    if (mod == 50)
    {

    }
    else if (g_ATLJSettings.ConfigType == 1)
    {
        j := itm
        loop, 10
        {
            GUiControl, ICScriptHub:, CbATLJMod50Itm%j%, %chk%
            j += 5
        }
    }
    else if (g_ATLJSettings.ConfigType == 2)
    {
        j := itm
        loop, 5
        {
            GUiControl, ICScriptHub:, CbATLJMod50Itm%j%, %chk%
            j += 10
        }
    }

    ;ATLJ_Save_Clicked()
    return
}

;instead of iterating through three complete arrays of 1s and 0s, we can shorten the array to specific zones or eliinate redundant arrays
ATLJ_CheckBoxToMod50()
{
    Gui, ICScriptHub:Submit, NoHide
    g_ATLJSettings.Mod50 := {}
    counter := 0
    loop, 50
    {
        if (CbATLJMod50Itm%A_Index% = 1)
        {
            g_ATLJSettings.Mod50.Push(A_Index)
            ++counter
        }
        if (CbATLJMod50Itm%A_Index% = -1)
        {
            g_ATLJSettings.Mod50.Push(-A_Index)
            ++counter
        }
    }
    if (counter == 0)
        g_ATLJSettings.Mod50 := false
    return
}

ATLJ_CheckBoxToLevelSlots()
{
    Gui, ICScriptHub:Submit, NoHide
    g_ATLJSettings.LevelSlots := {}
    counter := 0
    loop, 12
    {
        if (CbATLJLevelSlot%A_Index% = 1)
        {
            g_ATLJSettings.LevelSlots.Push(A_Index)
            ++counter
        }
    }
    if (counter == 0)
        g_ATLJSettings.LevelSlots := false
    return
}

ATLJ_CheckBoxToUltimates()
{
    Gui, ICScriptHub:Submit, NoHide
    g_ATLJSettings.Ultimates := {}
    counter := 0
    loop, 10
    {
        if (CbATLJUltimate%A_Index% = 1)
        {
            g_ATLJSettings.Ultimates.Push(A_Index)
            ++counter
        }
    }
    if (counter == 0)
        g_ATLJSettings.Ultimates := false
    return
}

class ATLJ_GuiUpdater
{
    Update(obj)
    {
        global
        if (!IsObject(obj))
            return
        
        static IsHewAlive
        if (IsHewAlive != obj.IsHewAlive)
        {
            IsHewAlive := obj.IsHewAlive
            GuiControl, ICScriptHub:, ATLJHew, % "Is Hew alive? " . IsHewAlive
        }
        static Monsters
        if (Monsters != obj.Monsters)
        {
            Monsters := obj.Monsters
            if (Monsters == "Too many monsers spawned, resetting zone.")
                GuiControl, ICScriptHub:, ATLJMonsters, % Monsters
            else
                GuiControl, ICScriptHub:, ATLJMonsters, % "Monsters spawned: " . Monsters
        }
        static Zone
        if (Zone != obj.Zone)
        {
            Zone := obj.Zone
            GuiControl, ICScriptHub:, ATLJZone, % "Current zone: " . Zone
        }
        static Haste
        if (Haste != obj.Haste)
        {
            Haste := obj.Haste
            GuiControl, ICScriptHub:, ATLJHaste, % "Haste stacks: " . Haste
        }
        static Formation
        if (Formation != obj.Formation)
        {
            Formation := obj.Formation
            if (Formation == "Formation 'e', canceling jump animation.")
                GuiControl, ICScriptHub:, ATLJFormation, % Formation
            else
                GuiControl, ICScriptHub:, ATLJFormation, % "formation: '" . Formation . "'"
        }
        static Fkeys
        Fkeys := 2
        if (Fkeys != obj.UseFkeys)
        {
            Fkeys := obj.UseFkeys
            if Fkeys
                GuiControl, ICScriptHub:, ATLJFkeys, % "Inputting the following Fkeys: " . obj.KeySpamTxt
            else
                GuiControl, ICScriptHub:, ATLJFkeys, % "Not inputting Fkeys."
        }
        static clickDamage
        clickDamage := 2
        if (clickDamage != obj.UseClick)
        {
            clickDamage := obj.UseClick
            if clickDamage
                GuiControl, ICScriptHub:, ATLJClick, % "Leveling click damage."
            else
                GuiControl, ICScriptHub:, ATLJClick, % "Not leveling click damage."
        }
    }
}

#include %A_LineFile%\..\IC_ATLJ_Functions.ahk