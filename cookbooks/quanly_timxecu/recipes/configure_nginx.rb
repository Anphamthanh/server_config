# Configure passenger and ruby
template '/etc/nginx/nginx.conf' do
  source 'nginx/nginx.conf.erb'
  variables({
    ruby_path: '/usr/local/bin/ruby'
  })
end

# Remove default Nginx
template '/etc/nginx/sites-available/default' do
  source 'nginx/nginx-default'
end

# Config for quanly
template '/etc/nginx/sites-available/quanly' do
  source 'nginx/quanly'
  variables({
    ip: node.ipaddress,
    root_dir: "#{node['git-server']['server-dir']}/public",
    server_name: node.nginx.server_name,
    ssl_certificate: node.nginx.ssl_certificate,
    ssl_certificate_key: node.nginx.ssl_certificate_key
  })
  not_if { ::File.exist? '/etc/nginx/sites-available/quanly' }
end

execute 'update sites-enable' do
  command 'ln -s /etc/nginx/sites-available/quanly /etc/nginx/sites-enabled/quanly'
  not_if { ::File.exist? '/etc/nginx/sites-enabled/quanly' }
end

execute 'reload nginx' do
  command 'nginx -s reload'
end

package 'python-pip'

execute 'install ngxtop' do
  command 'pip install ngxtop'
end
