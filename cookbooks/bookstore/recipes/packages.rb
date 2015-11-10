%w(
  'libmysqlclient-dev'
  'mysql-server'
  'mysql-client'
  'nginx'
  'nginx-extras'
).each do |pkg_to_install|
  package pkg_to_install
end

execute 'install mysql' do
  command 'gem install mysql2'
end

script 'add passenger' do
  interpreter 'bash'
  code <<-EOH
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
    echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main' >> /etc/apt/sources.list.d/passenger.list
    chown root: /etc/apt/sources.list.d/passenger.list
    chmod 600 /etc/apt/sources.list.d/passenger.list
  EOH
  user 'root'
end

execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
end

package 'passenger'
