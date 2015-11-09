%w(
  'libmysqlclient-dev'
  'mysql-server'
  'mysql-client'
  'nginx'
).each do |pkg_to_install|
  package pkg_to_install
end

execute 'install mysql' do
  command 'gem install mysql2'
end
