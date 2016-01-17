include_recipe 'setup::rails'
include_recipe 'setup::nginx_passenger'
include_recipe 'setup::mysql'

include_recipe 'bookstore::configure_nginx'
# copy secret key file to desired location before configure git
include_recipe 'bookstore::bookstore_git'

execute 'disable password authentication' do
  command "sed -i s/'#PasswordAuthentication yes'/'PasswordAuthentication no'/g /etc/ssh/sshd_config"
end

