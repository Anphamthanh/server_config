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

template '/etc/nginx/sites-available/bookstore' do
  source 'bookstore'
  variables({
    ip: node['ipaddress'],
    root_dir: "#{node['git-server']['server-dir']}/public"
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
