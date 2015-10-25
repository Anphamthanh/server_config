user 'git' do
  home '/home/git'
end

directory '/home/git/.ssh/' do
  recursive true
  owner 'git'
  group 'git'
  action :create
end

directory node['git-server']['working-dir'] do
  recursive true
  owner 'git'
  group 'git'
  mode '0755'
  action :create
end

execute 'create authorized_keys file' do
  command "echo '#{node['git-server']['public-key']}' > /home/git/.ssh/authorized_keys"
  user 'git'
  not_if { ::File.exist? '/home/git/.ssh/authorized_keys' }
end

execute 'add my public key' do
  command "echo '#{node['git-server']['public-key']}' >> /home/git/.ssh/authorized_keys"
  user 'git'
  not_if { `grep #{node['git-server']['public-key']} home/git/.ssh/authorized_keys | wc -l`.to_i > 0 }
end
