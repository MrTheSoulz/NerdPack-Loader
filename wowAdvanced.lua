local _, gbl = ...;

gbl.WowAdvanced = {}
local NEP_STREAM_WA = _G.CallSecureFunction and _G or _G.NEP_STREAM_WA

local function InternetRequestAsync(verb, url, parameters, extraHeader, callback)
    local id = NEP_STREAM_WA.InternetRequestAsyncInternal(verb, url, parameters, extraHeader)
    local update
    update = function ()
       local response, status = NEP_STREAM_WA.TryInternetRequestInternal(id)
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
        gbl.domain .. "/download-stream/init/wowadvanced",
        "",
        "",
        function(response, status)
            if tonumber(status) ~= 200 then
				print('Error while loading...', status);
				return;
			end
            gbl.init(response)
        end
    )
end