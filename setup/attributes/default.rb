default['git-server']['public-key'] = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCylogXfy6rtYGmhsdQhKQfmj/9MWKcFIwNL64CRF4pHei23oB2wmiMIjTV8Sy6L1eXOsIiIgwKWu/+PmkBsBXMLNwgZrnjCgnPLivLqxqHCDug8sxvTFmYeZyBPBkanJDigegXf03np2E9ZcdlZdC+PJkJbHCOj3Rbuyxsq8TTmLHZ6TUFpAiD6gfNe8BlxgHi4FLeC7BugNN+ynUPszn4afG8ugpwyGACHVBZVfF1t8FaF2H2Zlj7cymhPQmTwUECum44HhW+5kt2qIueF2jaISJJDHCXgWEuhP7GXG8wExz3LV0a4QNW2omCcDigBBwz0VWpNpRgSrKL8K0Nlc5n anpham@AnPham-WorkStation'
default['git-server']['working-dir'] = '/etc/git-server/'
default['apresume.com']['working-dir'] = "/var/www/apresume.com/"
default['apresume.com']['git-dir'] = "#{node['git-server']['working-dir']}apresume.com.git/"
