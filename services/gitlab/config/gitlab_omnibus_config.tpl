external_url '${gitlab_external_url}'
gitlab_rails['gitlab_shell_ssh_port'] = ${gitlab_ssh_port}

gitlab_rails['time_zone'] = 'Atlantic/Canary'

gitlab_rails['gitlab_signup_enabled'] = false

gitlab_rails['backup_keep_time'] = 604800

prometheus_monitoring['enable'] = true
