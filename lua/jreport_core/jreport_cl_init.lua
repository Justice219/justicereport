AddCSLuaFile("jreport_core/jreport_config.lua")
include('jreport_core/jreport_config.lua')

// tables
local Reports = {}
local ranks = jrconfig.Ranks

jrp = LocalPlayer()

// Fonts
surface.CreateFont( "TitleFont", {
	font = jrconfig.TitleFont1, --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = jrconfig.TitleFont1Size,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
} )
surface.CreateFont( "TitleFont2", {
	font = jrconfig.TitleFont2, --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = jrconfig.TitleFont2Size,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
} )

-- Yes!
local function JusticeWelcomeScreen()
    chat.AddText(jrconfig.OpenRMenuColor, "[Enigma Reports] ", Color(255,255,255,255), "Opened report menu!")
    print("opened menu!")
    
    // Is Valid Check
    if IsValid(Menu) then return end

    // Anim Locals
    local scrw, scrh = ScrW(), ScrH()
    local frameW, frameH, animTime, animDelay, animEase = scrw * .3, scrh * .18, jrconfig.PATime, jrconfig.PADelay, -1 
    local mSize = math.max(ScrW(), ScrH())

    //Other
    local reportee

    // Menu Code
    local Menu = vgui.Create( "DFrame" )
    Menu:SetPos( 200, 100 ) 
    Menu:SetTitle( jrconfig.RPTitle ) 
    Menu:SetVisible( true ) 
    Menu:SetDraggable( true ) 
    Menu:ShowCloseButton( false ) 
    Menu:MakePopup()
    local mS = Menu:GetSize()
    local isAnimating = true
    Menu:SizeTo(frameW, frameH, animTime, animDelay, animEase, function()
        isAnimating = true
    end)
    Menu.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
        draw.RoundedBox( 0, 0, 0, w, h, Color( 49, 49, 49) ) -- Draw a red box instead of the frame
    end

    // Close Button
    local CloseButton = vgui.Create("DImageButton", Menu)
    CloseButton:SetImage( "icon16/cross.png" )
    CloseButton:SetSize(ScrW() / 120 , ScrH() / 80)
    CloseButton:SetPos( (550/1920) * mSize, (5/1080) * mSize)
    CloseButton.DoClick = function()
        Menu:Remove()
    end

    //Topbar
    local topbar = vgui.Create("DPanel", Menu)
    topbar:Dock(TOP)
    topbar:SetSize(0,(3/1080) * mSize)
    topbar.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
        draw.RoundedBox( 6, 0, 0, w, h, Color( 255, 255, 255) ) -- Draw a red box instead of the frame
    end

    -- Panel 1
    local sp = vgui.Create("DScrollPanel", Menu)
    sp:Dock( FILL )
    sp.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
        draw.RoundedBox( 10, 0, 0, w, h, Color( 41, 41, 41) ) -- Draw a red box instead of the frame
    end

    // Player
    local PSelect = vgui.Create( "DComboBox", sp )
    PSelect:SetSize((200/1920) * mSize, (15/1080) * mSize)
    PSelect:DockMargin(10,5,10,5)
    PSelect:Dock(TOP)
    PSelect:SetValue( "Select a player to report!" )
    for k, v in ipairs(player.GetAll()) do
        PSelect:AddChoice( v:Nick() )
    end
    PSelect.OnSelect = function (self, index, value)
        reportee = player.GetAll()[index]
        local text = reportee:Nick()
    end
    
    // Description
    local Description = vgui.Create( "DTextEntry", sp )
    Description:Dock(TOP)
    Description:SetSize((400/1920) * mSize,(15/1080) * mSize)
    Description:DockMargin(10,5,10,5)
    Description:SetValue("Please give a reason!")

    // Send Button
    local DermaButton = vgui.Create( "DButton", sp ) // Create the button and parent it to the frame
    DermaButton:SetText( "Create Report!" )					// Set the text on the button
    DermaButton:SetTextColor(Color(255,255,255))
    DermaButton:SetPos( (360/1920) * mSize, (475/1080) * mSize )					// Set the position on the frame
    DermaButton:Dock(TOP)
    DermaButton:DockMargin(10,5,10,5)
    DermaButton:SetSize( (400/1920) * mSize, (20/1080) * mSize )					// Set the size
    DermaButton:SetIcon("icon16/accept.png")
    DermaButton.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
        draw.RoundedBox( 6, 0, 0, w, h, Color( 49, 49, 49) ) -- Draw a red box instead of the frame
    end
    DermaButton.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
        if (reportee == nil) then return end
        if (Description == nil) then return end
        net.Start("JCreateReport")
        net.WriteString(PSelect:GetValue())
        net.WriteString(Description:GetValue())
        net.WriteEntity(reportee)
        net.WriteString(reportee:Nick())
        net.SendToServer()
        
        print("Created Report!")
        Menu:Remove()
    end

    // Anim
    Menu.OnSizeChanged = function(me,w,h)
        if isAnimating then
            me:Center()
        end
    end

end

local function TicketPopup( Report )
    chat.AddText(jrconfig.TicketClaimedColor, "[Enigma Reports] ", Color(255,255,255,255), "Ticket claimed!")
    print("opened menu!")
    // Is Valid Check
    if IsValid(Menu) then return end

    // Anim Locals
    local scrw, scrh = ScrW(), ScrH()
    local frameW, frameH, animTime, animDelay, animEase = scrw * .5, scrh * .5, jrconfig.PATime, jrconfig.PADelay, -1

    // Other

    // Frame Code
    local Menu = vgui.Create( "DFrame" )
    Menu:SetPos(ScrW()-500-10, 10)
    Menu:SetSize( 500*ScrW()/1920, 280*ScrH()/1080 )
    Menu:SetTitle( jrconfig.RPTitle ) 
    Menu:SetVisible( true ) 
    Menu:SetDraggable( true ) 
    Menu:ShowCloseButton( false ) 
    Menu.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
        draw.RoundedBox( 0, 0, 0, w, h, Color( 49, 49, 49) ) -- Draw a red box instead of the frame
    end

    // Scroll frame
    local sp = vgui.Create("DScrollPanel", Menu)
    sp:Dock(FILL)
    sp.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
        draw.RoundedBox( 10, 0, 0, w, h, Color( 54, 54, 54) ) -- Draw a red box instead of the frame
    end
    // Label
    local R12 = vgui.Create( "DLabel", sp)
    R12:SetText("Reportee Section")
    R12:Dock(TOP)
    R12:DockMargin(4*ScrW()/1920, 4*ScrH()/1080, 4*ScrW()/1920, 0)
    local R1 = vgui.Create( "DLabel", sp )
    R1:SetText(Report.ReporteeID)
    R1:Dock(TOP)
    R1:DockMargin(4*ScrW()/1920, 4*ScrH()/1080, 4*ScrW()/1920, 0)

    // Buttons
    local B1 = vgui.Create( "DButton", sp )
    B1:SetText("Bring Reportee")
    B1:Dock(TOP)
    B1:DockMargin(4*ScrW()/1920, 4*ScrH()/1080, 4*ScrW()/1920, 0)
    B1:SetIcon("icon16/arrow_right.png")
    B1:SetTextColor(Color(255,255,255,255))
    B1.DoClick = function()
        local rid = Report.ReporteeID
        print(rid)
        RunConsoleCommand("sam", "bring", rid)
    end
    B1.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
        draw.RoundedBox( 1, 0, 0, w, h, Color( 41, 41, 41) ) -- Draw a red box instead of the frame
    end

    local B2 = vgui.Create( "DButton", sp )
    B2:SetText("Goto Reportee")
    B2:Dock(TOP)
    B2:DockMargin(4*ScrW()/1920, 4*ScrH()/1080, 4*ScrW()/1920, 0)
    B2:SetIcon("icon16/arrow_left.png")
    B2:SetTextColor(Color(255,255,255,255))
    B2.DoClick = function()
        local rid = Report.ReporteeID
        print(rid)
        RunConsoleCommand("sam", "goto", rid)
    end
    B2.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
        draw.RoundedBox( 1, 0, 0, w, h, Color( 41, 41, 41) ) -- Draw a red box instead of the frame
    end

    // Label
    local R2 = vgui.Create( "DLabel", sp )
    R2:SetText("Reporter Section")
    R2:Dock(TOP)
    R2:DockMargin(4*ScrW()/1920, 4*ScrH()/1080, 4*ScrW()/1920, 0)
    local R23 = vgui.Create( "DLabel", sp )
    R23:SetText(Report.PlayerID)
    R23:Dock(TOP)
    R23:DockMargin(4*ScrW()/1920, 4*ScrH()/1080, 4*ScrW()/1920, 0)

    // Buttons
    local B3 = vgui.Create( "DButton", sp )
    B3:SetText("Bring Reporter")
    B3:Dock(TOP)
    B3:DockMargin(4*ScrW()/1920, 4*ScrH()/1080, 4*ScrW()/1920, 0)
    B3:SetIcon("icon16/arrow_right.png")
    B3:SetTextColor(Color(255,255,255,255))
    B3.DoClick = function()
        local pid = Report.PlayerID
        print(pid)
        RunConsoleCommand("sam", "bring", pid)
    end
    B3.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
        draw.RoundedBox( 1, 0, 0, w, h, Color( 41, 41, 41) ) -- Draw a red box instead of the frame
    end
    
    local B4 = vgui.Create( "DButton", sp )
    B4:SetText("Goto Reporter")
    B4:Dock(TOP)
    B4:DockMargin(4*ScrW()/1920, 4*ScrH()/1080, 4*ScrW()/1920, 0)
    B4:SetIcon("icon16/arrow_left.png")
    B4:SetTextColor(Color(255,255,255,255))
    B4.DoClick = function()
        local pid = Report.PlayerID
        print(pid)
        RunConsoleCommand("sam", "goto", pid)
    end
    B4.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
        draw.RoundedBox( 1, 0, 0, w, h, Color( 41, 41, 41) ) -- Draw a red box instead of the frame
    end

    local Close = vgui.Create( "DButton", sp )
    Close:SetText("Close Ticket")
    Close:Dock(TOP)
    Close:DockMargin(4*ScrW()/1920, 4*ScrH()/1080, 4*ScrW()/1920, 0)
    Close:SetIcon("icon16/cross.png")
    Close:SetTextColor(Color(255,255,255,255))
    Close.DoClick = function()
        Menu:Remove()
    end
    Close.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
        draw.RoundedBox( 1, 0, 0, w, h, Color( 41, 41, 41) ) -- Draw a red box instead of the frame
    end
end

local function ReportAdminPanel()
    // Check

    chat.AddText(jrconfig.OpenAMenuColor, "[Enigma Reports] ", Color(255,255,255,255), "Opened admin menu!")
    print("opened menu!")
    
    // Is Valid Check
    if IsValid(Menu) then return end

    // Anim Locals
    local scrw, scrh = ScrW(), ScrH()
    local frameW, frameH, animTime, animDelay, animEase = scrw * .5, scrh * .5, jrconfig.PATime, jrconfig.PADelay, -1

    // Frame Code
    local Menu = vgui.Create( "DFrame" )
    Menu:SetPos( 200, 100 ) 
    Menu:SetTitle( jrconfig.RPTitle ) 
    Menu:SetVisible( true ) 
    Menu:SetDraggable( true ) 
    Menu:ShowCloseButton( true ) 
    Menu:MakePopup()
    local isAnimating = true
    Menu:SizeTo(frameW, frameH, animTime, animDelay, animEase, function()
        isAnimating = true
    end)
    Menu.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
        draw.RoundedBox( 0, 0, 0, w, h, Color( 49, 49, 49) ) -- Draw a red box instead of the frame
    end

    // Reports Panel
    ReportPanel = vgui.Create( "DPanel", Menu)
    ReportPanel:Dock(TOP)
    ReportPanel:DockMargin(10*ScrW()/1920, 5*ScrH()/1080, 10*ScrW()/1920, 5*ScrH()/1080)
    ReportPanel:SetPos( 200*ScrW()/1920, 100*ScrH()/1080 )
    ReportPanel:SetSize( 900*ScrW()/1920, 475*ScrH()/1080 )
    ReportPanel.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
        draw.RoundedBox( 4, 0, 0, w, h, Color( 41, 41, 41) ) -- Draw a red box instead of the frame
    end
    // Report Loop
    for k, v in ipairs(Reports) do

        local title = vgui.Create("DLabel", ReportPanel)
        title:Dock(TOP)
        title:DockMargin(4*ScrW()/1920, 4*ScrH()/1080, 4*ScrW()/1920, 0)
        title:SetText(v.Description)
    

        local button = vgui.Create( "DButton", ReportPanel )
        button:Dock(TOP)
        button:DockMargin(4*ScrW()/1920, 4*ScrH()/1080, 4*ScrW()/1920, 0)
        button:SetText("Claim Ticket!")
        button:SetTextColor(Color(255,255,255,255))
        button:SetIcon("icon16/accept.png")
        button.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
            draw.RoundedBox( 10, 0, 0, w, h, Color( 49, 49, 49) ) -- Draw a red box instead of the frame
        end
        button.DoClick = function()
            net.Start("RemoveReport")
            net.WriteUInt(k,10)
            net.SendToServer()

            TicketPopup( v )
            Menu:Remove()
        end
    end

    // Animation
    Menu.OnSizeChanged = function(me,w,h)
        if isAnimating then
            me:Center()
        end
    end
    
end
local function ReportNotification()
    // Is Valid Check
    if IsValid(Menu) then return end

    // Anim Locals
    local scrw, scrh = ScrW(), ScrH()
    local frameW, frameH, animTime, animDelay, animEase = scrw * .5, scrh * .5, jrconfig.PATime, jrconfig.PADelay, -1

    // Other

    // Frame Code
    local Menu = vgui.Create( "DFrame" )
    Menu:SetPos(ScrW()-500-10, 10)
    Menu:SetSize( 400*ScrW()/1920, 125*ScrH()/1080 )
    Menu:SetTitle( "" ) 
    Menu:SetVisible( true ) 
    Menu:SetDraggable( false ) 
    Menu:ShowCloseButton( false ) 
    Menu.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
        draw.RoundedBox( 2, 0, 0, w, h, Color( 49, 49, 49) ) -- Draw a red box instead of the frame
    end

    // Panel
    local infop = vgui.Create("DPanel", Menu)
    infop:Dock( BOTTOM )
    infop:DockMargin(5*ScrW()/1920, 0, 5*ScrW()/1920, 10*ScrH()/1080)
    infop:SetSize(400*ScrW()/1920,100*ScrH()/1080)
    infop.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
        draw.RoundedBox( 10, 0, 0, w, h, Color( 41, 41, 41) ) -- Draw a red box instead of the frame
    end

    local R1 = vgui.Create("DLabel", infop)
    R1:SetText("New Report Created! \n Use !reportsadmin")
    R1:Dock(TOP)
    R1:DockMargin(125*ScrW()/1920, 4*ScrH()/1080, 4*ScrW()/1920, 0)
    R1:SetSize(400*ScrW()/1920,100*ScrH()/1080)
    R1:SetFont("TitleFont2")

    timer.Simple( 3, function() 
        Menu:Remove() 
    end)
end

// Networking
net.Receive("OpenMenu", function (len, ply)
    if len >= 100 then return end
    JusticeWelcomeScreen()
end)
net.Receive("OpenAdminMenu", function (len, ply)
    if len >= 100 then return end
    ReportAdminPanel()
end)
net.Receive("ReportSync", function()
    Reports = net.ReadTable()
end)
net.Receive("JusticeAdminPopup", function()
    ReportNotification()
end)
concommand.Add("jreport_noti", function() ReportNotification() end)