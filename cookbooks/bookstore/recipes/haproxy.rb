%w(
  'unzip'
  'git'
  'vim'
  'htop'
).each do |pkg|
  package pkg
end

execute 'add haproxy PPA' do
  command 'sudo add-apt-repository ppa:vbernat/haproxy-1.6'
  not_if {
    `cat /etc/apt/sources.list.d/vbernat-haproxy-1_6-trusty.list | grep 'deb http://ppa.launchpad.net/vbernat/haproxy-1.6/ubuntu' | wc -l`.to_i > 0
  }
end

execute 'update apt cache' do
  command 'apt-get update'
  ignore_failure true
end

package 'haproxy'

template '/etc/haproxy/haproxy.cfg' do
  source 'haproxy.cfg'
  variables({
    backend_fqdn: node.haproxy.backend_fqdn
  })
end

template '/etc/rsyslog.conf' do
  source 'rsyslog.conf'
end

service 'rsyslog' do
  action :restart
end

service 'haproxy' do
  action :restart
end
