item_id = node['mo_server_reverse_proxy_cache']['id'] || node.fqdn

node.set['mo_server_reverse_proxy_cache']['virtual_host'] = {}

mo_apps_from_databag(node['mo_server_reverse_proxy_cache']['databag'], item_id, node['mo_server_reverse_proxy_cache']['applications_databag']) do |name, values|
  node.set['mo_server_reverse_proxy_cache']['virtual_host'][name] = values
end

node.set['mo_server_reverse_proxy_cache']['purge'] = data_bag_item(node['mo_server_reverse_proxy_cache']['databag'], item_id)['purge']

include_recipe 'mo_server_reverse_proxy_cache'
