item_id = node['role_proxy']['id'] || node.fqdn

data = data_bag_item(node['role_proxy']['databag'], item_id)

node.set['role_proxy']['virtual_host'] = data['virtual_host']

include_recipe 'role_proxy'
