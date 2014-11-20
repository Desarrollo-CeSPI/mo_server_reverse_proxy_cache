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

default['role_proxy']['virtual_host']['unlp']['main_name'] = "www.unlp.edu.ar"    # String
default['role_proxy']['virtual_host']['unlp']['server_names'] = "unlp.edu.ar"     # Array or string (just domain names, without www).
default['role_proxy']['virtual_host']['unlp']['template_source'] = nil
default['role_proxy']['virtual_host']['unlp']['template_cookbook'] = nil
default['role_proxy']['virtual_host']['unlp']['backends'] = [{ name: "unlp", host: "www.unlp.edu.ar", port: "80", probe: "" }]
