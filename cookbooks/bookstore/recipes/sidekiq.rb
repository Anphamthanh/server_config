template '/etc/init/sidekiq.conf' do
  source 'sidekiq/sidekiq_upstart.conf'
  variables({
    sidekiq_upstart_user: node.sidekiq.upstart_user,
    app_dir: node['git-server']['server-dir']
  })
  not_if { ::File.exists? '/etc/init/sidekiq.conf' }
end

template '/etc/init/workers.conf' do
  source 'sidekiq/sidekiq_workers_upstart.conf'
  variables({
    sidekiq_number_of_workers: node.sidekiq.number_of_workers
  })
  not_if { ::File.exists? '/etc/init/workers.conf' }
end
