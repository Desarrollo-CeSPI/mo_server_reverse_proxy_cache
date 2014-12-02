# General attributes.
default['role_proxy']['id'] = nil # defaults to fqdn
default['role_proxy']['databag'] = "proxy_servers"
default['role_proxy']['applications_databag'] = "applications"

# Varnish attributes.
default['varnish']['listen_port']     = 6000
default['varnish']['listen_address']  = "127.0.0.1"
default['varnish']['vcl_conf']        = "default.vcl"
default['varnish']['vcl_source']      = "varnish_default.vcl.erb"
default['varnish']['vcl_cookbook']    = "role_proxy"
default['varnish']['conf_source']     = "varnish_default.erb"
default['varnish']['conf_cookbook']   = "role_proxy"
default['varnish']['storage_size']    = "2GB"
default['varnish']['ttl']             = "600"
default['varnish']['storage']         = "malloc"
