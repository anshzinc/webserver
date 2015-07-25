local socket = require('socket')
local headers = require('headers')
local req_parser = require('request_parser')

local webserver = {}

-- Open socket

function webserver:init_server() 
	self.server = socket.bind('*', 3009)

	if not self.server then
		print("Error: Could not bind socket.\n")
		os.exit(0)
	end

	local ip, port = self.server:getsockname()

	print("Listening " .. ip .. ":" .. port)
end

-- Server loop

function webserver:run_server() 
	while 1 do
		local client = self.server:accept()
		client:settimeout(60)
		
		local line, err = client:receive()

		if not err then
			print("[Request] type: " .. req_parser:get_type(line) .. " url: " .. req_parser:get_url(line))
			local resp_file = io.open(self:map_url(req_parser:get_url(line)), 'r')	

			if resp_file then		

				self:map_url(req_parser:get_url(line))

				client:send(headers:get_200()  .. " " .. resp_file:read("*all") .. "\n") 
				resp_file:close()
			else
				client:send(headers:get_404() .. " " .. "<h1>404 Not Found</h1>\n")
			end
		end
	
		client:close()
	end
end

-- Router

function webserver:map_url(url) 
	local req_dirs = req_parser:split(url, "/")
	local base_dir = "./" -- for now let base dir to be same directory
	for _, v in ipairs(req_dirs) do
		base_dir = base_dir .. "/" .. v
	end

	file = base_dir .. "/index.html"
	return file
end

local server = webserver:init_server()
webserver:run_server()
