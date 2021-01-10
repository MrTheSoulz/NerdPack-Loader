local _, gbl = ...;

gbl.LB = {}

function gbl.LB.init()
	print('Loading...')
	_G.NeP_STREAM__LB__.HttpAsyncGet(
		gbl.domain,
		 443,
		 true,
		 '/download-stream/init/luabox',
		 function(content)
			pcall(gbl.init, content)
		 end,
		 function(xerror)
			print('Error while loading...')
		 end,
		 'Content-Type: application/json',
		 'Accept: application/json'
	)
end