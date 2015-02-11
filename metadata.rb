name             'mo_server_reverse_proxy_cache'
maintainer       'Christian A. Rodriguez & Leandro Di Tommaso'
maintainer_email 'chrodriguez@gmail.com leandro.ditommaso@mikroways.net'
license          'MIT'
description      'Installs/Configures mo_server_reverse_proxy_cache'
long_description 'Installs/Configures mo_server_reverse_proxy_cache'
version          '0.1.3'

depends   'certificate',      '~>0.6.3'
depends   'chef-sugar',       '~>2.4.1'
depends   'mo_application',   '~>0.1.24'
depends   'nginx_conf',       '~>0.2.4'
depends   'varnish',          '~>1.0.3'
