# Configure passenger and ruby
template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  variables({
    ruby_path: `which ruby`
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
    root_dir: "#{node['git-server']['server-dir']}public"
  })
end
