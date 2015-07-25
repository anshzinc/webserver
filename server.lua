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
			local resp_file = io.open("index.html", 'r')	
			client:send(headers:get_200()  .. " " .. resp_file:read("*all") .. "\n") 
			resp_file:close()
		end
	
		client:close()
	end
end

local server = webserver:init_server()
webserver:run_server()
