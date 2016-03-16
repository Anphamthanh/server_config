default['git-server']['source-dir'] = '/etc/git-server'
default['git-server']['server-dir'] = '/var/www/quanly'

default['secret_key_file_location'] = '/etc/.keys.yml'

default['letsencrypt']['install_path'] = '/opt/letsencrypt'
default['letsencrypt']['repo'] = 'https://github.com/letsencrypt/letsencrypt'

default['nginx']['server_name'] = 'timxecu.com www.timxecu.com quanly.timxecu.com www.quanly.timxecu.com'
default['nginx']['ssl_certificate'] = '/etc/letsencrypt/live/timxecu.com/fullchain.pem'
default['nginx']['ssl_certificate_key'] = '/etc/letsencrypt/live/timxecu.com/privkey.pem'
