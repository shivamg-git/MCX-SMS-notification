require 'uri'
require 'net/http'

url = URI("http://livemcxwatch.in/feed.php")

http = Net::HTTP.new(url.host, url.port)

request = Net::HTTP::Post.new(url)
request["accept"] = '*/*'
request["origin"] = 'http://livemcxwatch.in'
request["x-requested-with"] = 'XMLHttpRequest'
request["user-agent"] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36'
request["dnt"] = '1'
request["referer"] = 'http://livemcxwatch.in/'
request["accept-encoding"] = 'gzip, deflate'
request["accept-language"] = 'en-US,en;q=0.8'
request["cache-control"] = 'no-cache'
request["postman-token"] = '405e9501-9eb0-685c-70d2-7d55ed040cce'

response = http.request(request)
puts response.read_body



