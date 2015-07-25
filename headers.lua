local headers = {}

headers.get_200 = function() 
		return "HTTP/1.1 200 OK\r\nContent-type: text/html\r\n\r\n"
end

headers.get_404 = function()

	return "HTTP/1.1 404 Not Found\r\nContent-type: text/html\r\n\r\n"
end

headers.get_403 = function()
	return "HTTP/1.1 403 Forbidden\r\nContent-type: text/html\r\n\r\n"
end

headers.get_503 = function()
	return "HTTP/1.1 503 Internal Server Error\r\nContent-Type: text/html\r\n\r\n"
end



return headers

