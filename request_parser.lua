local req_parser = {}

-- Split a string. 

function req_parser:split(str, sep)
   local result = {}
   local regex = string.format("([^%s]+)", sep)
   for line,_ in str:gmatch(regex) do
      table.insert(result, line)
   end
   return result
end

-- Get request type from 

function req_parser:get_type(line)
	local lines = req_parser:split(line, " ")
	return lines[1]
end

-- Get request uri

function req_parser:get_url(line)
	local lines = req_parser:split(line, " ")
	return lines[2]
end

return req_parser

