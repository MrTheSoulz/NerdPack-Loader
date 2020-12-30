local n_name, gbl = ...;

if n_name:lower():match('nerdpack') then
	print('Your addon contains an invalid name, please redownload it.');
	return;
end

local version = 1;

local function initMB()
	print('Loading...')
	wmbapi.SendHttpRequest({
		Url = "https://nerdpack.xyz/download-stream/init",
		Method = "GET",
		Callback = function(request, status)
			-- Deal with the current status and response of the HTTP request here.
			if (status == "SUCCESS") then
				local _, response = wmbapi.ReceiveHttpResponse(request);
				local xstatus, xerror = pcall(RunScript, 'local local_stream_name = "' .. n_name .. '";\n' .. 'local local_stream_version = ' .. version .. ';\n' .. response.Body);
				if not xstatus then error(xerror) end
			elseif status ~= "REQUESTING" then
				print(status);
			end
		end
	});
end

C_Timer.After(5, function()
	if wmbapi then
		initMB()
	else
		print('No supported unlocker found, try again after launching one.')
	end
end)
