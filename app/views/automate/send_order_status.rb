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

def send_order_status(status, order_id, information, message = '')
  host = 'jellyfish-core-dev.dpi.bah.com'
  path = '/order_items/#{order_id}/provision_update'
  url = "http://#{host}#{path}"
  uri = URI.parse(url)

  information = information.merge('provision_status' => status.downcase)
  information = information.merge('id' => "#{order_id}")
  $evm.log('info', "send_order_status: Information: #{information}")
  json = {
    status: "#{status}",
    message: "#{message}",
    info: information
  }
  $evm.log('info', "send_order_status: Information #{json.to_json}")
  begin
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Put.new(uri.path)
    request.content_type = 'application/json'
    request.body = json.to_json
    response = http.request(request)
    $evm.log('info', "send_order_status: HTTP Response code: #{response.code}")
    $evm.log('info', "send_order_status: HTTP Response message: #{response.message}")
  rescue HTTPExceptions => e
    $evm.log('error', "send_order_status: HTTP Exception caught while sending response back to core: #{e.message}")
  rescue StandardError => e
    $evm.log('error', "send_order_status: Exception caught while sending response back to core: #{e.message}")
  end
end # End of function
