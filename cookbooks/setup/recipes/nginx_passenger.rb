

script 'add passenger' do
  interpreter 'bash'
  code <<-EOH
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
    echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main' >> /etc/apt/sources.list.d/passenger.list
    chown root: /etc/apt/sources.list.d/passenger.list
    chmod 600 /etc/apt/sources.list.d/passenger.list
  EOH
  user 'root'
  not_if { `cat /etc/apt/sources.list.d/passenger.list | grep passenger | wc -l`.to_i > 0 }
end

execute 'apt-get-update' do
  command 'apt-get update'
  ignore_failure true
end

%w(
  'nginx-extras'
  'passenger'
).each do |pkg_to_install|
  package pkg_to_install
end

execute 'remove bad ruby' do
  command 'sudo rm /usr/bin/ruby'
end

execute 'add symbolic link for correct ruby' do
  command 'sudo ln -s /usr/local/bin/ruby /usr/bin/ruby'
end
