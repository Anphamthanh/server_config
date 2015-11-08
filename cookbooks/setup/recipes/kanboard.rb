
include_recipe 'setup::apache_and_php'

remote_file '/var/www/kanboard.zip' do
  source 'https://www.dropbox.com/s/5obrj6trdthdku3/kanboard-latest.zip?dl=0'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute 'extract kanboard.zip' do
  command 'unzip kanboard.zip'
  cwd '/var/www/'
  not_if { File.exists?("/var/www/kanboard/") }
end

file '/var/www/kanboard.zip' do
  action :delete
end

directory '/var/www/kanboard/data/' do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  action :create
end
