if SERVER then
    include("jreport_core/jreport_sv_init.lua")
    include("jreport_core/jreport_config.lua")
    include("jreport_core/jreport_sv_save.lua")
    include("jreport_core/jreport_sv_debug.lua")
    AddCSLuaFile("jreport_core/jreport_config.lua")
    AddCSLuaFile("jreport_core/jreport_cl_init.lua")
  elseif CLIENT then
    include("jreport_core/jreport_config.lua")
    include("jreport_core/jreport_cl_init.lua")
  end