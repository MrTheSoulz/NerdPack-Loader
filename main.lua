local n_name, gbl = ...;

if n_name:lower():match('nerdpack') then
	print('Your addon contains an invalid name, please redownload it.');
	return;
end

gbl.domain = "nerdpack.xyz";
local version = 2;

if _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC then
	gbl.domain = 'classic.' .. gbl.domain
end

function gbl.init(body)
	local func, errorMessage = loadstring(
		'local local_stream_name = "' .. n_name .. '";\n' ..
		'local local_stream_version = ' .. version .. ';\n' ..
		body,
		n_name
	);
	if not func then
		print('Error initializing')
		print(errorMessage)
	end
	local success, xerrorMessage = pcall(func);
	if not success then
		print('Error initializing')
		print(xerrorMessage)
	end
end

local test
test = function()
	if wmbapi then
		pcall(gbl.MB.init)
	elseif EWT then
		pcall(gbl.EWT.init)
	elseif __LB__ then
		pcall(gbl.LB.init)
	elseif _G.NEP_STREAM_WA then
		pcall(gbl.WowAdvanced.init)
	else
		C_Timer.After(0, test)
	end
end

print('Searching for unlocker...')
C_Timer.After(0, test)
