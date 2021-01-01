local _, gbl = ...;

local function initMB()
	print('Loading...')
	wmbapi.SendHttpRequest({
		Url = "https://" .. gbl.domain .. "/download-stream/init/minibot",
		Method = "GET",
		Headers = "Content-Type: application/json\r\nAccept: application/json",
		Callback = function(request, status)
			if (status ~= "SUCCESS") then
				return;
			end
			local _, response = wmbapi.ReceiveHttpResponse(request);
			if tonumber(response.Code) ~= 200 then
				print('Error while loading...');
				return;
			end
			gbl:init(response.Body)
		end
	});
end