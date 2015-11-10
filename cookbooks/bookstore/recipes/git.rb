

directory node['git-server']['source-dir'] do
  recursive true
  mode '0755'
  action :create
end

execute 'setup bare git repo' do
  command 'git init --bare bookstore.git'
  cwd node['git-server']['source-dir']
  user 'git'
  not_if { ::File.exist? "#{node['git-server']['source-dir']}bookstore.git" }
end

directory node['git-server']['server-dir'] do
  recursive true
  mode '0755'
  action :create
end

template "#{node['git-server']['source-dir']}hooks/post-receive" do
  source 'post-receive-hook.erb'
  owner 'git'
  group 'git'
  mode '0755'
  variables({
    working_dir: node['git-server']['server-dir'],
    git_dir: "#{node['git-server']['source-dir']}bookstore.git"
  })
end

