jreportdata = jreportdata or {}
jreportfuncs = jreportfuncs or {}

function jreportfuncs.JReportReadData()
	-- Make sure you use the same filename as the one in file.Write!
	local JSONData = file.Read("jreportdata.json")

	-- JSONData is currently a JSON string - let's convert that into a table:
	local data = util.JSONToTable(JSONData)

	-- Remember how the col value does not get converted into a Color structure? Let's fix that:

	jreportdata = data
end

function jreportfuncs.JReportSaveData()
	local converted = util.TableToJSON(jreportdata)
	file.Write("jreportdata.json", converted)
end
function jreportfuncs.JReportSaveDataT(tbl)


	local converted = util.TableToJSON(jreportdata)
	file.Write("jreportdata.json", converted)
end

-- Lets load our data!
jreportfuncs.JReportReadData()