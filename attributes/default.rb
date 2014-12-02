# General attributes.
default['mo_server_reverse_proxy_cache']['id'] = nil # defaults to fqdn
default['mo_server_reverse_proxy_cache']['databag'] = "proxy_servers"
default['mo_server_reverse_proxy_cache']['applications_databag'] = "applications"

# Varnish attributes.
default['varnish']['listen_port']     = 6000
default['varnish']['listen_address']  = "127.0.0.1"
default['varnish']['vcl_conf']        = "default.vcl"
default['varnish']['vcl_source']      = "varnish_default.vcl.erb"
default['varnish']['vcl_cookbook']    = "mo_server_reverse_proxy_cache"
default['varnish']['conf_source']     = "varnish_default.erb"
default['varnish']['conf_cookbook']   = "mo_server_reverse_proxy_cache"
default['varnish']['storage_size']    = "2GB"
default['varnish']['ttl']             = "600"
default['varnish']['storage']         = "malloc"
