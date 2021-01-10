local _, gbl = ...;

gbl.WowAdvanced = {}
local g = _G.NEP_STREAM_WA

local function passApis(response)
    response = response ..
    "\nfor k,v in pairs(_G.NEP_STREAM_WA) do NeP._G[k] = v end;" ..
    "_G.NEP_STREAM_WA = nil;"
    pcall(gbl.init, response)
end

local function InternetRequestAsync(verb, url, parameters, extraHeader, callback)
    local id = g.InternetRequestAsyncInternal(verb, url, parameters, extraHeader)
    local update
    update = function ()
       local response, status = g.TryInternetRequestInternal(id)
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
            passApis(response)
        end
    )
end