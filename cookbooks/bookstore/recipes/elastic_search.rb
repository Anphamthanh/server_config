
execute 'add Oracle Java 8 PPA' do
  command 'add-apt-repository ppa:openjdk-r/ppa'
end

execute 'update apt cache' do
  command 'apt-get update'
  ignore_failure true
end

execute 'install Java 8' do
  command 'apt-get -y install openjdk-8-jdk'
end

remote_file '/opt/elasticsearch-2.1.1.deb' do
  source 'https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.1.1/elasticsearch-2.1.1.deb'
  user 'root'
  not_if { ::File.exist? '/opt/elasticsearch-2.1.1.deb' }
end

execute 'install elastic search' do
  command 'dpkg -i /opt/elasticsearch-2.1.1.deb'
end

execute 'clean up deb file' do
  command 'rm /opt/elasticsearch-2.1.1.deb'
  not_if { !::File.exist? '/opt/elasticsearch-2.1.1.deb' } 
end