include_recipe 'chef-sugar'
include_recipe 'nginx'

node['mo_server_reverse_proxy_cache']['virtual_host'].each do |vhost|
  applications_for(vhost).each do |app|
    nginx_conf_file "#{vhost[0]}_#{app[:name]}" do
      listen app[:listen] || "80"
      upstream "#{vhost[0]}_#{app[:name]}" => {"server" => "#{node['varnish']['listen_address']}:#{node['varnish']['listen_port']}"}
      server_name app[:server_name]
      locations({
          "/" => {
            "proxy_set_header" => {
              "X-Forwarded-For" => "$proxy_add_x_forwarded_for",
              "Host" => "$http_host"
            },
            'proxy_redirect' => 'off',
            'proxy_pass' => "http://#{vhost[0]}_#{app[:name]}"
          }
        })
      notifies :reload, "service[nginx]"
    end
    if app[:ssl]
      nginx_conf_file "#{vhost[0]}_#{app[:name]}_ssl" do
        listen app[:listen_ssl] || "443"
        upstream "#{vhost[0]}_#{app[:name]}_ssl" => {"server" => "#{node['varnish']['listen_address']}:#{node['varnish']['listen_port']}"}
        server_name app[:server_name]
        locations({
            "/" => {
              "proxy_set_header" => {
                "X-Forwarded-For" => "$proxy_add_x_forwarded_for",
                "Host" => "$http_host"
              },
              'proxy_redirect' => 'off',
              'proxy_pass' => "http://#{vhost[0]}_#{app[:name]}_ssl"
            }
          })
        notifies :reload, "service[nginx]"
        ssl ssl_for(app)
      end
    end
  end
end
