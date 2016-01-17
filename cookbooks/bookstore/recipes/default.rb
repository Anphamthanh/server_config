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

package 'unzip'

execute 'configure ssh access' do
  command 'mv /root/.ssh/authorized_keys /deployer/.ssh/authorized_keys'
  not_if { `cat /deployer/.ssh/authorized_keys | grep anp | wc -l`.to_i > 0 }
end
