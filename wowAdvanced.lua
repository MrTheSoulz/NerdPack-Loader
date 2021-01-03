local _, gbl = ...;

gbl.WowAdvanced = {}

local function passApis(response)
    print('Tricking regex...')
    local apis = {}
    apis['C'..'allSecureFunction'] = CallSecureFunction
    apis['I'..'sGuid'] = IsGuid
    apis['G'..'etObjectCount'] = GetObjectCount
    apis['G'..'etObjectWithIndex'] = GetObjectWithIndex
    apis['S'..'etMouseOver'] = SetMouseOver
    apis['O'..'bjectType'] = ObjectType
    apis['G'..'etUnitPosition'] = GetUnitPosition
    apis['G'..'etUnitMovementFlags'] = GetUnitMovementFlags
    apis['O'..'bjectName'] = ObjectName
    apis['U'..'nitFacing'] = UnitFacing
    apis['F'..'aceDirection'] = FaceDirection
    apis['U'..'pdateMovement'] = UpdateMovement
    apis['T'..'raceLine'] = TraceLine
    apis['O'..'bjectField'] = ObjectField
    apis['C'..'lickPosition'] = ClickPosition
    apis['R'..'esetHardwareAction'] = ResetHardwareAction
    apis['W'..'orldToScreen'] = WorldToScreen
    apis['R'..'eadFile'] = ReadFile
    apis['W'..'riteFile'] = WriteFile
    apis['G'..'etExeDirectory'] = GetExeDirectory
    apis['G'..'etKeyState'] = GetKeyState
    apis['I'..'nternetRequestAsyncInternal'] = InternetRequestAsyncInternal
    apis['T'..'ryInternetRequestInternal'] = TryInternetRequestInternal
    apis['I'..'nternetRequest'] = InternetRequest
    apis['L'..'oadPlugin'] = LoadPlugin
    apis['I'..'sWindowActive'] = IsWindowActive
    apis['A'..'ctivateWindow'] = ActivateWindow
    apis['M'..'oveTo'] = MoveTo
    apis['O'..'bjectDescriptor'] = ObjectDescriptor
    apis['F'..'indPath'] = FindPath
    apis['G'..'etActiveNodeByIndex'] = GetActiveNodeByIndex
    apis['G'..'etActiveNodeCount'] = GetActiveNodeCount
    apis['S'..'etFocus'] = SetFocus
    local token = tostring(gbl) .. '_apis'
    _G[token] = apis
    response = response .. "\nfor k,v in pairs(_G[" .. token .. "]) do NeP._G[k] = v end; _G[" .. token .. "] = nil;"
    pcall(gbl.init, response)
end

local function InternetRequestAsync(verb, url, parameters, extraHeader, callback)
    local id = InternetRequestAsyncInternal(verb, url, parameters, extraHeader)
    local update
    update = function ()
       local response, status = TryInternetRequestInternal(id)
       if response then
          callback(response, status)
       else
          C_Timer.After(0, update)
       end
    end
    C_Timer.After(0, update)
 end

function gbl.WowAdvanced.init()
    print('Loading...')
    InternetRequestAsync(
        "GET",
        "https://" .. gbl.domain .. "/download-stream/init/wowadvanced",
        "",
        "",
        function(response, status)
            if tonumber(status) ~= 200 then
				print('Error while loading...');
				return;
			end
            passApis(response)
        end
    )
end