local n_name, gbl = ...;

if n_name:lower():match('nerdpack') then
	print('Your addon contains an invalid name, please redownload it.');
	return;
end

gbl.domain = "nerdpack.xyz";
local version = 3;

if _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC then
	gbl.domain = 'classic.' .. gbl.domain
end

local function errorhandler(err)
	return geterrorhandler()(err)
end

local NEP_STREAM_WA = _G.NEP_STREAM_WA


function gbl.init(body)
	local func, errorMessage = loadstring(
		'local local_stream_name = "' .. n_name .. '";\n' ..
		'local local_stream_version = ' .. version .. ';\n' ..
		body,
		n_name
	);
	if not func then
		print('Error initializing')
		errorhandler(errorMessage)
	end
	if NEP_STREAM_WA then
		_G.NEP_STREAM_WA = nil
		local custom_env = setmetatable({local_streamed_apis = NEP_STREAM_WA}, {__index=_G})
		setfenv(func, custom_env)
	end
	local success, xerrorMessage = xpcall(func, errorhandler);
	if not success then
		print('Error initializing')
		errorhandler(xerrorMessage)
	end
end

local test
test = function()
	if wmbapi then
		gbl.MB.init()
	elseif EWT then
		gbl.EWT.init()
	elseif __LB__ then
		gbl.LB.init()
	elseif _G.CallSecureFunction or NEP_STREAM_WA then
		gbl.WowAdvanced.init()
	else
		C_Timer.After(0, test)
	end
end

print('Searching for unlocker...')
C_Timer.After(0, test)
