local _, gbl = ...;

local function initEwt()
	print('Loading...')
	SendHTTPRequest("https://" .. gbl.domain .. '/download-stream/init/ewt', nil, 
		function(body, code, req, res, err)
			if tonumber(code) ~= 200 then
				print('Error while loading...');
				return;
			end
			gbl:init(body)
		end,
		"Content-Type: application/json\r\nAccept: application/json"
	) 
end