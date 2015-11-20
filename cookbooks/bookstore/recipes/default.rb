include_recipe 'setup::rails'
include_recipe 'bookstore::packages'
include_recipe 'bookstore::configure_nginx'
include_recipe 'bookstore::mysql'



