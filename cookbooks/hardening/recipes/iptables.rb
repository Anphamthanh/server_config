
package 'iptables' do
  action :install
end

package 'iptables-persistent' do
  action :install
end

service 'iptables-persistent' do
  action [:start, :enable]
end

execute 'set default to accept all, and flush' do
  command 'iptables --policy INPUT ACCEPT; iptables --policy OUTPUT ACCEPT; iptables --flush'
end

execute 'accept ssh in' do
  command "iptables --append INPUT --protocol tcp --dport #{node['ssh']['port']} --jump ACCEPT"
end

execute 'accept ping in' do
  command 'iptables --append INPUT --protocol icmp --jump ACCEPT'
end

execute 'accept http in' do
  command 'iptables --append INPUT --protocol tcp --dport 80 --jump ACCEPT'
end

execute 'accept https in' do
  command 'iptables --append INPUT --protocol tcp --dport 443 --jump ACCEPT'
end

execute 'drop all other traffic' do
  command 'iptables --append INPUT --jump DROP'
end

execute 'save all rules' do
  command '/sbin/iptables-save > /etc/iptables/rules.v4'
end
