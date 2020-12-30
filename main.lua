local n_name, gbl = ...;

if n_name:lower():match('nerdpack') then
	print('Your addon contains an invalid name, please redownload it.');
	return;
end

local version = 1;

local function init(body)
	local xstatus, xerror = pcall(RunScript, 'local local_stream_name = "' .. n_name .. '";\n' .. 'local local_stream_version = ' .. version .. ';\n' .. body);
	if not xstatus then error(xerror) end
end

local function initEwt()
	print('Loading...')
	SendHTTPRequest('https://nerdpack.xyz/download-stream/init', nil, 
		function(body, code, req, res, err)
			if code ~= '200' then
				print('Error while loading...');
				return;
			end
			init(body)
		end,
		"Content-Type: application/json\r\nAccept: application/json"
	) 
end

local function initMB()
	print('Loading...')
	wmbapi.SendHttpRequest({
		Url = "https://nerdpack.xyz/download-stream/init",
		Method = "GET",
		Headers = "Content-Type: application/json\r\nAccept: application/json",
		Callback = function(request, status)
			if (status ~= "SUCCESS") then
				return;
			end
			local _, response = wmbapi.ReceiveHttpResponse(request);
			if response.Code ~= '200' then
				print('Error while loading...');
				return;
			end
			init(response.Body)
		end
	});
end

local function initLB()
	print('Loading...')
	__LB__.HttpAsyncGet(
		'https://nerdpack.xyz/download-stream/init',
		 443, 
		 true, 
		 '', 
		 function(content)
			init(content)
		 end, 
		 function(xerror)
			print('Error while loading...')
		 end, 
		 'Content-Type: application/json', 
		 'Accept: application/json'
	)
end

C_Timer.After(5, function()
	if wmbapi then
		initMB()
	elseif ewt then
		initEwt()
	elseif __LB__ then
		initLB()
	else
		print('No supported unlocker found, try again after launching one.')
	end
end)
