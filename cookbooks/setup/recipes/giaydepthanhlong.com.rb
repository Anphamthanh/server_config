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
