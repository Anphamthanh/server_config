# Configure passenger and ruby
template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  variables({
    ruby_path: '/usr/local/bin/ruby'
  })
end

# Remove default Nginx
template '/etc/nginx/sites-available/default' do
  source 'nginx-default'
end

# Config for bookstore
template '/etc/nginx/sites-available/bookstore' do
  source 'bookstore'
  variables({
    ip: node.ipaddress,
    root_dir: "#{node['git-server']['server-dir']}/public",
    server_name: node.nginx.server_name,
    ssl_certificate: node.nginx.ssl_certificate,
    ssl_certificate_key: node.nginx.ssl_certificate_key
  })
  not_if { ::File.exist? '/etc/nginx/sites-available/bookstore' }
end

execute 'update sites-enable' do
  command 'ln -s /etc/nginx/sites-available/bookstore /etc/nginx/sites-enabled/bookstore'
  not_if { ::File.exist? '/etc/nginx/sites-enabled/bookstore' }
end

execute 'reload nginx' do
  command 'nginx -s reload'
end

package 'ngxtop'

execute 'install ngxtop' do
  command 'pip install ngxtop'
end
