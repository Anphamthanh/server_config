include_recipe 'setup::apache_and_php'
include_recipe 'setup::git_server'

execute 'setup bare git repo' do
  command 'git init --bare apresume.com.git'
  cwd node['git-server']['working-dir']
  user 'git'
  not_if { ::File.exist? "#{node['git-server']['working-dir']}apresume.com.git" }
end

directory node['apresume.com']['working-dir'] do
  recursive true
  owner 'git'
  group 'git'
  mode '0755'
  action :create
end

# Allow apache2 to write recaptcha image to folder delete
directory "#{node['apresume.com']['working-dir']}delete" do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  action :create
end

template "#{node['apresume.com']['git-dir']}hooks/post-receive" do
  source 'post-receive-hook.erb'
  owner 'git'
  group 'git'
  mode '0755'
  variables({
    working_dir: node['apresume.com']['working-dir'],
    git_dir: node['apresume.com']['git-dir']
  })
end

template "/etc/apache2/sites-available/#{node['apresume.com']['apache-conf']}" do
  source 'virtual-host.conf.erb'
  mode '0755'
  variables({
    admin_email: node['production-server']['admin-email'],
    server_name: node['apresume.com']['server-name'],  
    server_root: node['apresume.com']['working-dir']
  })
  not_if { ::File.exist? "/etc/apache2/sites-available/#{node['apresume.com']['apache-conf']}" }
end

execute 'enable apresume conf' do
  command "a2ensite #{node['apresume.com']['apache-conf']}"
end

service 'apache2' do
  action :restart
end
