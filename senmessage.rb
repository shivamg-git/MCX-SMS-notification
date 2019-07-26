require 'uri'
require 'net/http'
require 'openssl'
require 'rubygems'
require 'json'


url = URI("https://smsservice-spider007.c9users.io/sendmessage.php")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["cookie"] = 'XDEBUG_SESSION=cloud9ide'

50.times do
	request.body = "mess=hi!!! &mob=9718455700"

	response = http.request(request)
	puts response.code
end