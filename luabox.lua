local _, gbl = ...;

gbl.LB = {}

local function passApis(response)
    response = response ..
        "\nfor k,v in pairs(_G.NeP_STREAM__LB__) do NeP._G[k] = v end;\n" ..
        "NeP._G.__LB__ = _G.NeP_STREAM__LB__;\n" ..
        "_G.NeP_STREAM__LB__ = nil;\n"
    pcall(gbl.init, response)
end

function gbl.LB.init()
	print('Loading...')
	_G.NeP_STREAM__LB__.HttpAsyncGet(
		gbl.domain,
		 443,
		 true,
		 '/download-stream/init/luabox',
		 function(content)
			passApis(content)
		 end,
		 function(xerror)
			print('Error while loading...')
		 end,
		 'Content-Type: application/json',
		 'Accept: application/json'
	)
end