
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
).each do |pkg_to_install|
  package pkg_to_install
end

git node['rails']['rbenv'] do
  repository 'git://github.com/sstephenson/rbenv.git'
  reference 'master'
  action :sync
end

directory "#{node['rails']['rbenv']}plugins"

git "#{node['rails']['rbenv']}plugins/ruby-build" do
  repository 'git://github.com/sstephenson/ruby-build.git'
  reference 'master'
  action :sync
end

git "#{node['rails']['rbenv']}plugins/rbenv-vars" do
  repository 'git://github.com/sstephenson/rbenv-vars.git'
  reference 'master'
  action :sync
end

script 'update bash_profile' do
  interpreter 'bash'
  code <<-EOH
    cd
    echo 'export PATH="#{node['rails']['rbenv']}bin:$PATH"' >> $HOME/.bash_profile
    echo 'eval "$(rbenv init -)"' >> $HOME/.bash_profile
    echo 'export PATH="#{node['rails']['rbenv']}plugins/ruby-build/bin:$PATH"' >> $HOME/.bash_profile
  EOH
  user 'root'
end

execute 'install ruby 2.2.1' do
  command "RUBY_CONFIGURE_OPTS=--disable-install-doc #{node['rails']['rbenv']}bin/rbenv install -v 2.2.1"
end

execute 'set ruby 2.2.1 as default' do
  command "#{node['rails']['rbenv']}bin/rbenv global 2.2.1"
end

# execute 'disable gem docs' do
#   command 'echo "gem: --no-rdoc --no-ri" > /root/.gemrc'
# end

execute 'rehash rbenv shims' do
  command "#{node['rails']['rbenv']}/bin/rbenv rehash"
end

execute 'install javascript runtime' do
  command 'add-apt-repository ppa:chris-lea/node.js; apt-get update; apt-get install -y nodejs'
end

execute 'install rails' do
  command 'gem install bundler rails --no-rdoc --no-ri'
end


