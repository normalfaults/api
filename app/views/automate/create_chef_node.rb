# This script uses the Chef gem and the Chef Server API
# To create a new node, assign it an IP Address and role 

require 'chef'
require 'net/http'
require 'chef/http'
require 'json'

def send_order_status(referer, headers, status, information, message = '')
  order_id = information['id']
  path = "/order_items/#{order_id}/provision_update"
  host = URI.parse(referer).host
  url = "http://#{host}#{path}"
  uri = URI.parse(url)

  information = information.merge('provision_status' => status.downcase)
  $evm.log('info', "send_order_status: Information: #{information}")
  json = {
    status: "#{status}",
    message: "#{message}",
    info: information
  }
  $evm.log('info', "send_order_status: Information #{json}")
  begin
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Put.new(uri.path)
    request.add_field('X-Staff-Email', "#{headers[0]}")
    request.add_field('X-Staff-Token', "#{headers[1]}")
    request.content_type = 'application/json'
    request.body = json.to_json
    response = http.request(request)
    $evm.log('info', "send_order_status: HTTP Response code: #{response.code}")
    $evm.log('info', "send_order_status: HTTP Response message: #{response.message}")
  rescue StandardError => e
    $evm.log('error', "send_order_status: Exception caught while sending response back to core: #{e.message}")
  end
end # End of function

# Retrieve properties from payload from core

product_details = $evm.root['dialog_product_details']
$evm.log('info', "CreateEC2: Product Details: #{product_details}")
product_hash = JSON.parse(product_details.gsub("'", '"').gsub('=>', ':'))
uuid = $evm.root['dialog_uuid']
order_id = product_hash['id']
ip_address = product_hash['ip_address']
$evm.root('info', "chef_automation: ip address #{ip_address}")
chef_role = product_hash['chef_role']
$evm.root('info', "chef_automation: chef role #{chef_role}")
chef_run_list = product_hash['chef_run_list']
referer = $evm.root['dialog_referer']
headers = [$evm.root['dialog_email'], $evm.root['dialog_token']]

info = {
  uuid: uuid,
  id: order_id
}

# This is the standard location for the chef client file
# on a server
Chef::Config.from_file('//etc/chef/client.rb')

hash = {
  'name' => "#{ip_address}",
  'chef_environment' => '_default',
  'json_class' => 'Chef::Node',
  'automatic' => {
    'ipaddress' => "#{ip_address}",
    'recipes' => [],
    'roles' => ["#{chef_role}"]
  },
  'normal' => {},
  'chef_type' => 'node',
  'default' => {},
  'override' => {},
  'run_list' => ["#{chef_run_list}"]
}

begin
  node = Chef::Node
  new_node_2 = node.json_create(hash)
  new_node_2.create
rescue StandardError => e
  send_order_status(referer, headers, 'CRITICAL', info, e.message)
end
