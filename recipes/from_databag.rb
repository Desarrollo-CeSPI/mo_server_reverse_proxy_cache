item_id = node['role_proxy']['id'] || node.fqdn

node.set['role_proxy']['virtual_host'] = {}

mo_apps_from_databag(node['role_proxy']['databag'], item_id, node['role_proxy']['applications_databag']) do |name, values|
  node.set['role_proxy']['virtual_host'][name] = values
end

node.set['role_proxy']['purge'] = data_bag_item(node['role_proxy']['databag'], item_id)['purge']

include_recipe 'role_proxy'
