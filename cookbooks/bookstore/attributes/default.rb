default['git-server']['source-dir'] = '/etc/git-server'
default['git-server']['server-dir'] = '/var/www/bookstore'

default['secret_key_file_location'] = '/etc/.keys.yml'

default['elasticsearch']['data_path'] = '/home/deployer/elasticsearch'

default['haproxy']['backend_fqdn'] = 'backend.ez-items.com'

default['letsencrypt']['install_path'] = '/opt/letsencrypt'
default['letsencrypt']['repo'] = 'https://github.com/letsencrypt/letsencrypt'

default['nginx']['server_name'] = 'ez-items.com www.ez-items.com backend.ez-items.com www.backend.ez-items.com'
default['nginx']['ssl_certificate'] = '/etc/letsencrypt/live/ez-items.com/fullchain.pem'
default['nginx']['ssl_certificate_key'] = '/etc/letsencrypt/live/ez-items.com/privkey.pem'

