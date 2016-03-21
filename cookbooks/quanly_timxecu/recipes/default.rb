%w(
  'unzip'
  'git'
  'vim'
  'htop'
  'bc'
  'python-pip'
  'libmagickwand-dev'
  'imagemagick'
).each do |pkg|
  package pkg
end

include_recipe 'quanly_timxecu::rails'
include_recipe 'quanly_timxecu::nginx_passenger'
include_recipe 'quanly_timxecu::configure_nginx'

include_recipe 'quanly_timxecu::configure_swap'
include_recipe 'quanly_timxecu::quanly_git'

# need a user deployer with sudo privilege to configure ssh. Make sure to create deployer user in cloudinit
include_recipe 'quanly_timxecu::configure_ssh'
