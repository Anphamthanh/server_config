

directory node['git-server']['source-dir'] do
  recursive true
  mode '0755'
  action :create
end

execute 'setup bare git repo' do
  command 'git init --bare bookstore.git'
  cwd node['git-server']['source-dir']
  not_if { ::File.exist? "#{node['git-server']['source-dir']}/bookstore.git" }
end

directory node['git-server']['server-dir'] do
  recursive true
  mode '0755'
  action :create
end

template "#{node['git-server']['source-dir']}/bookstore.git/hooks/post-receive" do
  source 'post-receive-hook.erb'
  mode '0755'
  variables({
    working_dir: node['git-server']['server-dir'],
    git_dir: "#{node['git-server']['source-dir']}/bookstore.git",
    keys_file: node['secret_key_file_location']
  })
end

