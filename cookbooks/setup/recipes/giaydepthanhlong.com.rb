include_recipe 'setup::apache_and_php'
include_recipe 'setup::git_server'

execute 'setup bare git repo' do
  command 'git init --bare giaydepthanhlong.com.git'
  cwd node['git-server']['working-dir']
  user 'git'
  not_if { ::File.exist? "#{node['git-server']['working-dir']}giaydepthanhlong.com.git" }
end

directory node['giaydepthanhlong.com']['working-dir'] do
  recursive true
  owner 'git'
  group 'git'
  mode '0755'
  action :create
end

template "#{node['giaydepthanhlong.com']['git-dir']}hooks/post-receive" do
  source 'post-receive-hook.erb'
  owner 'git'
  group 'git'
  mode '0755'
  variables({
    working_dir: node['giaydepthanhlong.com']['working-dir'],
    git_dir: node['giaydepthanhlong.com']['git-dir']
  })
end

template "/etc/apache2/sites-available/#{node['giaydepthanhlong.com']['apache-conf']}" do
  source 'virtual-host.conf.erb'
  mode '0755'
  variables({
    admin_email: node['production-server']['admin-email'],
    server_name: node['giaydepthanhlong.com']['server-name'],  
    server_root: node['giaydepthanhlong.com']['working-dir']
  })
  not_if { ::File.exist? "/etc/apache2/sites-available/#{node['giaydepthanhlong.com']['apache-conf']}" }
end

execute 'enable giaydepthanhlong conf' do
  command "a2ensite #{node['giaydepthanhlong.com']['apache-conf']}"
end

service 'apache2' do
  action :restart
end
