local n_name, gbl = ...;

if n_name:lower():match('nerdpack') then
	print('Your addon contains an invalid name, please redownload it.');
	return;
end

gbl.domain = "nerdpack.xyz";
local version = 2;

function gbl:init(body)
	local xstatus, xerror = pcall(
		RunScript, 
		'local local_stream_name = "' .. n_name .. '";\n' .. 
		'local local_stream_version = ' .. version .. ';\n' .. 
		body
	);
	if not xstatus then error(xerror) end
end

C_Timer.After(5, function()
	if wmbapi then
		gbl.MB:init()
	elseif EWT then
		gbl.Ewt:init()
	elseif __LB__ then
		gbl.LB:init()
	else
		print('No supported unlocker found, try again after launching one.')
	end
end)
