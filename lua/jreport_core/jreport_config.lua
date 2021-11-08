jrconfig = jrconfig or {}

-- Basic stuff
jrconfig.Ranks = {
    ["superadmin"] = true,
    ["admin"] = true,
    ["owner"] = true,
    ["tmod"] = true,
    ["mod"] = true,
    ["headadmin"] = true,
    ["operator"] = true,
    ["user"] = false,
}

jrconfig.DebugMode = true -- ENABLE THIS IF SCRIPT IS BEING WORKED ON

--[[ UI stuff

    RPTitle - Frame title of the report panels
    RPMTitle - Big title in the actual report panel
    RPDesc - description of the report panel

    TitleFont1 - The font of the report panel title
    TitleFont1Size - Size of font
    TitleFont2 - The font of the report subtitle
    TitleFont2Size - Size of font


--]]
jrconfig.RPTitle = "Enigma Reports v1.0"
jrconfig.RPMTitle = "Enigma Reports"
jrconfig.RPDesc = "Welcome to Enigma Reports! With this panel you can report a player to the staff team! \n Please give a " ..
"small description on what happened, ex) I was rdmed for no reason!. \n Make sure you select a player and enter a reason "..
"otherwise your report will not go through \n and you will not recieve support!"

jrconfig.TitleFont1 = "Trebuchet24" -- Use the gmod list of fonts or something
jrconfig.TitleFont1Size = 30
jrconfig.TitleFont2 = "Trebuchet24" -- Use the gmod list of fonts or something
jrconfig.TitleFont2Size = 20

--[[ Chat Messages

    OpenRMenuColor - The color of the message when the report panel is opened!
    OpenAMenuColor - The color of the message when the admin panel is opened!
    TicketClaimedColor - The color of the message when the ticket is claimed!

--]]
jrconfig.OpenRMenuColor = Color(238,255,0)
jrconfig.OpenAMenuColor = Color(238,255,0)
jrconfig.TicketClaimedColor = Color(238,255,0)

--[[ Animations
    PATime - Panel opening animation time
--]]
jrconfig.PATime = 1
jrconfig.PADelay = 0 