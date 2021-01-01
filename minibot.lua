local _, gbl = ...;

gbl.MB = {}

function gbl.MB.init()
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
			pcall(gbl.init, response.Body)
		end
	});
end