%w(
  'libmysqlclient-dev'
  'mysql-server'
  'mysql-client'
).each do |pkg_to_install|
  package pkg_to_install
end

execute 'install mysql' do
  command 'gem install mysql2'
end

execute 'create database dir structure' do
  command 'sudo mysql_install_db'
end

execute 'remove dangerous default setting' do
  command 'sudo msql_secure_installation'
end
