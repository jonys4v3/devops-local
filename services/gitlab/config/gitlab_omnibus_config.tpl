<<<<<<< HEAD
external_url ENV['GITLAB_EXTERNAL_URL'] || 'http://localhost:8080'

gitlab_rails['gitlab_shell_ssh_port'] = (ENV['GITLAB_SSH_PORT'] || '2222').to_i

gitlab_rails['time_zone'] = ENV['TZ'] || 'Atlantic/Canary'
=======
external_url '${gitlab_external_url}'
gitlab_rails['gitlab_shell_ssh_port'] = ${gitlab_ssh_port}

gitlab_rails['time_zone'] = 'Atlantic/Canary'

gitlab_rails['gitlab_signup_enabled'] = false

gitlab_rails['backup_keep_time'] = 604800
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38

prometheus_monitoring['enable'] = true
