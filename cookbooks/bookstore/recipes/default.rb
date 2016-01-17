include_recipe 'setup::rails'
include_recipe 'setup::nginx_passenger'
include_recipe 'setup::mysql'

include_recipe 'bookstore::configure_nginx'
include_recipe 'bookstore::elastic_search'
# copy secret key file to desired location before configure git
include_recipe 'bookstore::bookstore_git'

execute 'disable password authentication' do
  command "sed -i s/'#PasswordAuthentication yes'/'PasswordAuthentication no'/g /etc/ssh/sshd_config"
end

execute 'disable root login' do
  command "sed -i s/'#PermitRootLogin yes'/'PermitRootLogin no'/g /etc/ssh/sshd_config"
end

package 'unzip'

directory '/home/deployer/.ssh' do
  recursive true
  user 'deployer'
end

execute 'configure ssh access' do
  command 'cp /root/.ssh/authorized_keys /home/deployer/.ssh/authorized_keys; chown -R deployer /home/deployer/.ssh/authorized_keys'
  not_if { (::File.exist? '/home/deployer/.ssh/authorized_keys') && (`cat /home/deployer/.ssh/authorized_keys | grep anp | wc -l`.to_i > 0) }
end
