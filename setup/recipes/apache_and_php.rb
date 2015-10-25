
# Apache and PHP5
%w(
  'unzip'
  'build-essential'
  'apache2'
  'php5'
  'libapache2-mod-php5'
  'php5-mcrypt'
  'php5-sqlite'
  'php5-gd'
  'libapache2-mod-php5'
  'libapache2-mod-proxy-html'
  'libxml2-dev'
).each do |pkg_to_install|
  package pkg_to_install
end

# Enable proxy modules
%w(
  'proxy'
  'proxy_http'
  'proxy_ajp'
  'rewrite'
  'deflate'
  'headers'
  'proxy_balancer'
  'proxy_connect'
  'proxy_html'
  'xml2enc'
).each do |apache_module|
  execute apache_module do
    command "a2enmod #{apache_module}"
  end
end

template '/etc/apache2/sites-enabled/000-default.conf' do
  source '000-default.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/apache2/apache2.conf' do
  source 'apache2.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
end
