default['git-server']['source-dir'] = '/etc/git-server'
default['git-server']['server-dir'] = '/var/www/quanly'

default['secret_key_file_location'] = '/etc/.keys.yml'

default['letsencrypt']['install_path'] = '/opt/letsencrypt'
default['letsencrypt']['repo'] = 'https://github.com/letsencrypt/letsencrypt'

default['nginx']['server_name'] = 'quanly.timxecu.com www.quanly.timxecu.com'
default['nginx']['ssl_certificate'] = '/etc/letsencrypt/live/quanly.timxecu.com/fullchain.pem'
default['nginx']['ssl_certificate_key'] = '/etc/letsencrypt/live/quanly.timxecu.com/privkey.pem'