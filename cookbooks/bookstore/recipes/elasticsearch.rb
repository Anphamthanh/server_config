
execute 'add Oracle Java 8 PPA' do
  command 'add-apt-repository ppa:openjdk-r/ppa'
  not_if { ::File.exist? '/etc/apt/sources.list.d/openjdk-r-ppa-trusty.list' }
end

execute 'update apt cache' do
  command 'apt-get update'
  ignore_failure true
end

package 'openjdk-8-jdk'

remote_file '/opt/elasticsearch-2.1.1.deb' do
  source 'https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.1.1/elasticsearch-2.1.1.deb'
  user 'root'
  not_if { `ps aux | grep /usr/share/elasticsearch/lib/elasticsearch-2.1.1.jar | wc -l`.to_i > 2 }
end

execute 'install elastic search' do
  command 'dpkg -i /opt/elasticsearch-2.1.1.deb'
  not_if { `ps aux | grep /usr/share/elasticsearch/lib/elasticsearch-2.1.1.jar | wc -l`.to_i > 2 }
end

execute 'clean up deb file' do
  command 'rm /opt/elasticsearch-2.1.1.deb'
  not_if { !::File.exist? '/opt/elasticsearch-2.1.1.deb' } 
end

execute 'start elasticsearch on start up' do
  command 'update-rc.d elasticsearch defaults 95 10'
end

directory '/elasticsearch/data' do
  user 'elasticsearch'
  recursive true
end

template '/etc/elasticsearch/elasticsearch.yml' do
  source 'elasticsearch.yml'
  user 'elasticsearch'
  variables({
    es_data_path: node.elasticsearch.data_path  
  })
end

es_heap_size = node.memory.total[0..-3].to_i / 2 / 10**3
if es_heap_size > 1000
  es_heap_size = "#{es_heap_size / 1000}g"
else
  es_heap_size = "#{es_heap_size}m"
end

template '/etc/default/elasticsearch' do
  source 'elasticsearch'
  user 'elasticsearch'
  variables({
    es_data_path: node.elasticsearch.data_path,
    es_heap_size: es_heap_size
  })
end

service 'elasticsearch' do
  action :restart
end
