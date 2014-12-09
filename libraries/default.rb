def varnish_port
  node['varnish']['listen_port']
end

def varnish_ip
  node['varnish']['listen_address']
end

def applications_for(vhost)
  apps = []
  vhost.last["applications"].each do |a|
    app = Hash.new
    app[:name] = a[0]
    app[:server_name] = a[1]["server_name"]
    app[:listen] = a[1]["listen"]
    app[:ssl] = a[1]["ssl"]
    apps << app
  end
  apps
end

def ssl_for(app)
  certs = encrypted_data_bag_item(app[:ssl][:certificate_databag] || "certificates", app[:ssl][:certificate_id])
  {"public" => certs["cert"],
   "private" => certs["key"]}
end
