
execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
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

script 'install' do
  interpreter 'bash'
  code <<-EOH
    cd
    git clone git://github.com/sstephenson/rbenv.git .rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

    git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
    source ~/.bash_profile

    rbenv install -v 2.2.1
    rbenv global 2.2.1

    # disable gem docs
    echo "gem: --no-document" > ~/.gemrc

    gem install bundler
    gem install rails

    rbenv rehash

    # javascript runtime
    sudo add-apt-repository ppa:chris-lea/node.js
    sudo apt-get update
    sudo apt-get install nodejs

    # mySQL database
    sudo apt-get install mysql-server mysql-client libmysqlclient-dev
    gem install mysql2
  EOH
end
