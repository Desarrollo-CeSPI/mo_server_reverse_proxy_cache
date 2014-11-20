include_recipe 'varnish'

template "/etc/varnish/backend_definitions.vcl" do
  source "backend_definitions.vcl.erb"
  notifies :restart, "service[varnish]"
end
