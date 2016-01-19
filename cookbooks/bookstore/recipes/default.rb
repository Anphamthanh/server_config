%w(
  'unzip'
  'git'
  'vim'
).each do |pkg|
  package pkg
end

package 'unzip'
# need a user deployer with sudo privilege

include_recipe 'setup::rails'
include_recipe 'setup::nginx_passenger'
include_recipe 'setup::mysql'

include_recipe 'bookstore::configure_nginx'
include_recipe 'bookstore::elastic_search'
# copy secret key file to desired location before configure git
include_recipe 'bookstore::bookstore_git'
include_recipe 'bookstore::configure_ssh'
