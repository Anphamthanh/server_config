
execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
end

%w(
  'git-core'
  'curl'
  'zlib1g-dev'
  'build-essential'
  'libssl-dev'
  'libreadline-dev'
  'libyaml-dev'
  'libsqlite3-dev'
  'sqlite3'
  'libxml2-dev'
  'libxslt1-dev'
  'libcurl4-openssl-dev'
  'python-software-properties'
  'libffi-dev'
  'libgmp-dev'
).each do |pkg_to_install|
  package pkg_to_install
end

execute 'get ruby 2.2.3 source' do
  command 'wget https://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz'
  cwd '/tmp/'
  not_if { `ruby -v`.include? '2.2.3' }
end

execute 'extract ruby source' do
  command 'tar xzvf ruby-2.2.3.tar.gz'
  cwd '/tmp/'
  not_if { `ruby -v`.include? '2.2.3' }
end

execute 'configure ruby source' do
  command './configure --prefix=/usr/local --disable-install-doc'
  cwd '/tmp/ruby-2.2.3'
  not_if { `ruby -v`.include? '2.2.3' }
end

execute 'make ruby source' do
  command 'make'
  cwd '/tmp/ruby-2.2.3'
  not_if { `ruby -v`.include? '2.2.3' }
end

execute 'install ruby' do
  command 'make install'
  cwd '/tmp/ruby-2.2.3'
  not_if { `ruby -v`.include? '2.2.3' }
end

execute 'disable gem docs' do
  command 'echo "gem: --no-rdoc --no-ri" > /root/.gemrc'
end

execute 'install javascript runtime' do
  command 'add-apt-repository ppa:chris-lea/node.js; apt-get update; apt-get install -y nodejs'
end

execute 'install rails' do
  command 'gem install bundler rails --no-rdoc --no-ri'
end



