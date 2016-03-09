remote_file '/opt/redis.tar.gz' do
  source 'http://download.redis.io/releases/redis-stable.tar.gz'
  not_if { ::File.exists? '/opt/redis.tar.gz' }
end

execute 'untar redis' do
  command 'tar xzf redis.tar.gz'
  cwd '/opt/'
  not_if { ::File.exists? '/opt/redis-stable' }
end

execute 'make redis' do
  command 'make'
  cwd '/opt/redis-stable'
end

execute 'make install redis' do
  command 'sudo make install'
  cwd '/opt/redis-stable'
end

execute 'install redis server' do
  command 'sudo ./install_server.sh'
  cwd '/opt/redis-stable/utils'
end

execute 'auto start redis' do
  command 'sudo update-rc.d redis_6379 defaults'
end
