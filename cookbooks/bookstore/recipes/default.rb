include_recipe 'setup::rails'
include_recipe 'setup::nginx_passenger'
include_recipe 'setup::mysql'

include_recipe 'bookstore::configure_nginx'
include_recipe 'bookstore::elastic_search'
# copy secret key file to desired location before configure git
include_recipe 'bookstore::bookstore_git'
include_recipe 'bookstore::configure_ssh'

package 'unzip'

user 'deployer' do
  home '/home/deployer'
  shell '/bin/bash'
end
