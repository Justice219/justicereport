// Network Stuff
util.AddNetworkString("OpenMenu")
util.AddNetworkString("OpenAdminMenu")
util.AddNetworkString("JCreateReport")
util.AddNetworkString("SendReport")
util.AddNetworkString("ReportSync")
util.AddNetworkString("RemoveReport")
util.AddNetworkString("JusticeAdminPopup")
util.AddNetworkString("JRSaveData")

// Config shit
AddCSLuaFile("jreport_config.lua")
include('jreport_config.lua')

// Tables
local Reports = {}
local ranks = jrconfig.Ranks

hook.Add("PlayerSay", "JRSVC", function(ply, text)
    if string.lower(text) == "!report" then
        
        net.Start( "OpenMenu" )
        net.Send(ply);

    end
    if string.lower(text) == "!reports" then
        if not (ranks[ply:GetUserGroup()]) then return end
        net.Start( "OpenAdminMenu" )
        net.Send(ply);
    end
    if string.lower(text) == "!sits" then
        local data = ply:GetPData("jrsitcount", 0)
        ply:PrintMessage(HUD_PRINTTALK, "You currently have, " .. data .. " sits!")
    end
end)

net.Receive("JCreateReport", function(len, ply)
    table.insert( Reports, {
        Player = net.ReadString(),
        Description = net.ReadString(),
        ReporteeE = net.ReadEntity(),
        ReporteeID = net.ReadString(),
        PlayerID = ply:Nick()

    })
    for k, v in ipairs(player.GetAll()) do
        if not (ranks[v:GetUserGroup()]) then return end
        v:PrintMessage(HUD_PRINTTALK, "A new staff ticket has been created! Access it with !reportsadmin")
        net.Start("JusticeAdminPopup")
        net.Send(v)
    end

end)
net.Receive("RemoveReport", function(len, ply)
    if not (ranks[ply:GetUserGroup()]) then return end
    if len >= 100 then return end
    local k = net.ReadUInt( 10 )
    table.remove( Reports, k)
end)

net.Receive("JRSaveData", function(len, ply)
    ply:SetPData("jrsitcount", ply:GetPData("jrsitcount", 0) + 1)
end)

timer.Create( "ReportsSyncTimer", 5, 0, function()
    for k, v in ipairs(player.GetAll()) do
      if not v:IsAdmin() then continue end
      net.Start( "ReportSync" )
        net.WriteTable( Reports )
      net.Send( v )
    end
  end )
