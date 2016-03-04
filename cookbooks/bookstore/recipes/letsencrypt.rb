git node.letsencrypt.install_path do
  repository node.letsencrypt.repo
  reference 'master'
  action :sync
  not_if { ::File.exists? node.letsencrypt.install_path }
end

execute 'install letsencrypt' do
  command 'ln -s /opt/letsencrypt/letsencrypt-auto /usr/local/bin/letsencrypt'
  not_if { ::File.exists? '/usr/local/bin/letsencrypt' }
end

# new cert /opt/letsencrypt/letsencrypt-auto certonly --standalone
#./letsencrypt-auto certonly --agree-tos --renew-by-default --standalone-supported-challenges http-01 --http-01-port 54321 -d ez-items.com -d www.ez-items.com -d backend.ez-items.com -d www.backend.ez-items.com
# letsencrypt certonly --agree-tos --renew-by-default --standalone-supported-challenges http-01 -d ez-items.com -d www.ez-items.com -d backend.ez-items.com -d www.backend.ez-items.com
