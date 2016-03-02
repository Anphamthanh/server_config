%w(
  'unzip'
  'git'
  'vim'
  'htop'
).each do |pkg|
  package pkg
end


include_recipe 'setup::rails'
include_recipe 'setup::nginx_passenger'
include_recipe 'setup::mysql'

include_recipe 'bookstore::configure_nginx'
include_recipe 'bookstore::elastic_search'
include_recipe 'bookstore::configure_swap'
include_recipe 'bookstore::bookstore_git'

# need a user deployer with sudo privilege to configure ssh. Make sure to create deployer user in cloudinit
include_recipe 'bookstore::configure_ssh'
