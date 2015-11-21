include_recipe 'setup::rails'
include_recipe 'setup::nginx_passenger'
include_recipe 'setup::mysql'

include_recipe 'bookstore::configure_nginx'
# copy key file to desired location before configure git hook
# include_recipe 'bookstore::bookstore_git'



