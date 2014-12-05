# mo_server_reverse_proxy_cache-cookbook

This cookbook provides recipes to configure a server with Nginx and Varnish to be used
as a reverse proxy and a fast cache for high load websites.

## Supported Platforms

Tested on Ubuntu 12.04, should work in 14.04.

## Recipes

This cookbook provides two recipes:

* default: this recipe can be used just by setting the appropiate attributes.
* from_databag: this recipe uses data bags to configure the server.

### from_databag

This recipe uses two databags defined in the following attributes:

1. node['mo_server_reverse_proxy_cache']['databag']
2. node['mo_server_reverse_proxy_cache']['applications_databag']

The first attribute is the databag where the applications that will be proxied are listed.
The second one indicates the databag where each of those applications are defined.

#### Examples

Main databag.

```json
{
  "id": "proxy.vagrant.desarrollo.unlp.edu.ar",
  "applications": ["unlp", "albergue", "alumnos"],
  "purge": {
    "localhost": {
      "ip": "localhost",
      "deny": false
    },
    "host_allowed": {
      "ip": "10.100.8.1/32",
      "deny": false
    },
    "disallowed_host": {
      "ip": "10.0.0.1/32",
      "deny": true
    },
    "development_network": {
      "ip": "10.0.0.0/24",
      "deny": false
    }
  }
}
```

* id: name of the server (as specified in node['mo_server_reverse_proxy_cache']['id']). If the attribute
  is nil, FQDN is used instead.
* applications: an array with each application that will be proxied by the server with the corresponding id.
* purge: a hash that will form the ACL to permit or deny purge.

Applications databag.

```json
{
"id": "albergue",
  "staging": {
    "application_servers": [
      "desarrollo.unlp.edu.ar"
    ],
    "cache" : {
      "port": 80,
      "probe": {
        "url": "/",
        "timeout": "2s",
        "interval": "6s",
        "window": 6,
        "threshold": 2
      }
    },
    "applications": {
      "frontend": {
        "server_name": "albergue.vagrant.desarrollo.unlp.edu.ar",
        "ssl": {
          "certificate_name": null
        }
      },
      "backend": {
        "server_name": "admin-albergue.vagrant.desarrollo.unlp.edu.ar",
        "ssl": {
          "certificate_name": null
        }
      }
    }
  }
}
```

* id: the application identifier. This name is the one that goes in the list of applications proxied by the server.
* staging: the environment in which the values are valid. The recipe **from_databag** automatically uses the values
  that correspond to the environment in which the server is.
* application_servers: the servers listed here will be the backends.
* cache: this sections specifies some customizations for Varnish.
  * port: the port where the backends expect to receive connections from Varnish. Defaults to 80.
  * probe: how to probe the backends. If ommited default values are applied (backends are always probed). It's
    possible to specify every value or just some of them (the ones not included will get default values).
* applications: the list of applications for the main application. Some applications have for example a backend and
  a frontend. For each of those, an entry in the default VCL will be included to match the hostname. It's important to
  know that every application defined here will use the same backends specified in "application_servers".
* server_name: could be a string with one hostname or an array with several hostnames. If it is an array, every
  hostname will be used to match the request, but the hostname of the requirement will be overwriten to use the first
  value in the array.

## Attributes

Both recipes (default and from_databag) will read attributes, the main difference is that the second one
will read them from databags and then set the corresponding attributes. That said, when using just attributes,
without databags, the databag structure must be represented. For example, to specify the list of applications:

```
node['mo_server_reverse_proxy_cache']['applications'] = ["unlp", "albergue", "alumnos"]
```

### Varnish

This cookbook uses [Varnish comunity cookbook](https://github.com/rackspace-cookbooks/varnish) and for that it
needs to set some attributes defined by that cookbook. For a detailed list and explanation see the README in that cookbook.

## Usage

To use this cookbook, you need to define the attributes or databags as indicated above and then add to the node's
run list either default or from_databag recipe.

## To-Do

* Add Nginx in front with support for SSL.
* Add tests.

## License and Authors

* Author:: Christian Rodriguez (chrodriguez@gmail.com)
* Author:: Leandro Di Tommaso (leandro.ditommaso@mikroways.net)

