require 'uri'
require 'net/http'
require 'openssl'
require 'rubygems'
require 'json'

url = URI("https://www.mcxindia.com/backpage.aspx/GetMarketWatch")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["accept"] = 'application/json, text/javascript, */*; q=0.01'
request["origin"] = 'https://www.mcxindia.com'
request["x-requested-with"] = 'XMLHttpRequest'
request["user-agent"] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36'
request["content-type"] = 'application/json'
request["dnt"] = '1'
request["referer"] = 'https://www.mcxindia.com/market-data/market-watch'
request["accept-encoding"] = 'gzip, deflate, br'
request["accept-language"] = 'en-US,en;q=0.8'
request["cache-control"] = 'no-cache'

response = http.request(request)
res_json =  JSON.parse(response.read_body)['d']["Data"]

message1 = "GOLD\n" 
message2 = "SILVER\n" 


res_json.each do |ex|
	if ex['Symbol'] == "GOLD" and ex['LTP'] != 0
		message1 +=ex["ExpiryDate"] + " " + ex["Low"].to_i.to_s + " " + ex["LTP"].to_i.to_s + " " + ex["High"].to_i.to_s+ "\n"
	end

	if ex['Symbol'] == "SILVER" and ex['LTP'] != 0
		message2 +=ex["ExpiryDate"] + " " + ex["Low"].to_i.to_s + " " + ex["LTP"].to_i.to_s + " " + ex["High"].to_i.to_s + "\n"
	end

end

puts message1
puts
puts message2

url = URI("https://smsservice-spider007.c9users.io/sendmessage.php")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["cookie"] = 'XDEBUG_SESSION=cloud9ide'
request.body = "mess=#{message1}&mob=9718455700"

response = http.request(request)
puts response.code

request.body = "mess=#{message2}&mob=9718455700"
response = http.request(request)
puts response.code