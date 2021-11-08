include('jreport_sv_save.lua')
include('jreport_config.lua')

-- Locals
local ranks = jrconfig.Ranks

hook.Add("PlayerSay", "JRSaveData", function(ply, text)
    if jrconfig.DebugMode == false then return end
    if not (ranks[ply:GetUserGroup()]) then return end
    if string.lower(text) == "!jreport_sdata" then
        
        table.insert( jreportdata, {
            user = {
                player = ply,
                playern = ply:Nick()
            }
        })

        jreportfuncs.JReportSaveData()
        jreportfuncs.JReportReadData()

        PrintTable(jreportdata)
        DarkRP.notify(player, 1, 3, "Save data has been ran!")
    end
    if string.lower(text) == "!jreport_rdata" then
        
        PrintTable(jreportdata)
        DarkRP.notify(player, 1, 3, "you have read table data!")
    end
    if string.lower(text) == "!jreport_cdata" then
        
        local tbl = {}
        jreportdata = tbl

        jreportfuncs.JReportSaveData()
        jreportfuncs.JReportReadData()

        PrintTable(jreportdata)
        DarkRP.notify(player, 1, 3, "you have read table data!")
    end
    
end)