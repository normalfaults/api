
# Created by Jillian Tullo
# 01/05/2015

# Function sends back an order status back to the marketplace
# Statuses:
# "OK" : Action was completed without issues
# "WARNING" : Action was completed, but something happened during process that may cause an issue
# "CRITICAL" Action was NOT completed without issues
# "UNKNOWN" : Action response was out of bounds, or something happened that wasn't expected
# "PENDING" : Action pending

# Status refers to the above codes
# Message is the error code if Critical or Warning
# Information is information regarding the service if it was completed unsuccessfully (Hash form)
require 'net/http'
require 'uri/http'
require 'json'

def send_order_status(status, order_id, information, message="")

  port = 3000
  host = "localhost"
  path ="/order_item/#{order_id}"

  if information != ""
    info_response = information.to_json
  end
  json = %{
    {
    "status" : "#{status}","message" : "#{message}","information" : #{info_response}
    }
  }
  puts json.to_json
  #TODO Send the actual HTTP Post request
  req = Net::HTTP::Put.new(path, initheader = {'Content-Type' => 'application/json'})
  req.body = json
  response = Net::HTTP.new(host, port).start {|http| http.request(req) }
  puts response
end # End of function


# TESTING PURPOSES ONLY BELOW:
# DELETE FROM SCRIPT
information = {
    "test1" => "testa",
    "test2" => "testb",
    "test3" => "testc",
    "test4" => "testd"
}

send_order_status("OK",2, information)
