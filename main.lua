local n_name, gbl = ...;

if n_name:lower():match('nerdpack') then
	print('Your addon contains an invalid name, please redownload it.');
	return;
end

local version = 1;

local function initMB()
	print('Loading...')
	wmbapi.SendHttpRequest({
		Url = "http://127.0.0.1:8000/test-stream",
		Method = "GET",
		Callback = function(request, status)
		  -- Deal with the current status and response of the HTTP request here.
		  if (status == "SUCCESS") then
			local _, response = wmbapi.ReceiveHttpResponse(request);
			local status, xerror = pcall(RunScript, 'local local_stream_name = "' .. n_name .. '";\n' .. 'local local_stream_version = ' .. version .. ';\n' .. response.Body);
			if not status then error(xerror) end
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
