execute 'disable password authentication' do
  command "sed -i s/'#PasswordAuthentication yes'/'PasswordAuthentication no'/g /etc/ssh/sshd_config"
end

execute 'disable root login' do
  command "sed -i s/'PermitRootLogin yes'/'PermitRootLogin no'/g /etc/ssh/sshd_config"
end

directory '/home/deployer/.ssh' do
  recursive true
  user 'deployer'
end

execute 'configure ssh access' do
  command 'mv /root/.ssh/authorized_keys /home/deployer/.ssh/authorized_keys; chown -R deployer /home/deployer/.ssh/authorized_keys'
  not_if { (::File.exist? '/home/deployer/.ssh/authorized_keys') && (`cat /home/deployer/.ssh/authorized_keys | grep anp | wc -l`.to_i > 0) }
end
