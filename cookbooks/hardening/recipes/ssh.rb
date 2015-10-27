
execute 'change ssh default port' do
  command "sed -i 's/Port.*/Port #{node['ssh']['port']}/' /etc/ssh/sshd_config"
end

service 'ssh' do
  action :restart
end
