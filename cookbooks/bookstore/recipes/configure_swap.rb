swap_size = node['memory']['total'][0..-3].to_i * 2 / 10**6

execute 'allocating swap file' do
  command "fallocate -l #{swap_size}G /swapfile"
  user 'root'
  not_if { ::File.exists? '/swapfile' }
end

file '/swapfile' do
  mode '600'
  owner 'root'
  group 'root'
end

execute 'create swap space' do
  command 'sudo mkswap /swapfile'
end

execute 'turn on swap' do
  command 'sudo swapon /swapfile'
  not_if { `swapon -s | grep swapfile | wc -l`.to_i > 0 }
end

execute 'add swap to fstab' do
  command 'echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab'
  not_if { `cat /etc/fstab | grep swap | wc -l`.to_i > 0 }
end

execute 'configure swappiness' do
  command 'echo "vm.swappiness=30" >> /etc/sysctl.conf'
  not_if { `cat /etc/sysctl.conf | grep vm.swappiness | wc -l`.to_i > 0 }
end

