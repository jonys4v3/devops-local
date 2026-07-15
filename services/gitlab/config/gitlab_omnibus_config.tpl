external_url ENV['GITLAB_EXTERNAL_URL'] || 'http://localhost:8080'

gitlab_rails['gitlab_shell_ssh_port'] = (ENV['GITLAB_SSH_PORT'] || '2222').to_i

gitlab_rails['time_zone'] = ENV['TZ'] || 'Atlantic/Canary'

prometheus_monitoring['enable'] = true
