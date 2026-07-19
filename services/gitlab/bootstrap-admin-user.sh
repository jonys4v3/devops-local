#!/usr/bin/env bash
set -euo pipefail

CONTAINER="$1"
USERNAME="$2"
EMAIL="$3"
PASSWORD="$4"

echo "Waiting for GitLab to be ready in ${CONTAINER}..."

for i in $(seq 1 120); do
  if docker exec "${CONTAINER}" gitlab-rails runner "puts 'ok'" >/dev/null 2>&1; then
    break
  fi

  sleep 10

  if [[ "$i" == "120" ]]; then
    echo "GitLab was not ready in time" >&2
    exit 1
  fi
done

echo "Ensuring GitLab root password..."

docker exec "${CONTAINER}" gitlab-rails runner "
root = User.find_by_username('root')
if root
  root.password = '${PASSWORD}'
  root.password_confirmation = '${PASSWORD}'
  root.admin = true
  root.save!
  puts 'GitLab root password ensured'
else
  puts 'Root user not found'
end
"

echo "Ensuring GitLab admin user ${USERNAME}..."

docker exec "${CONTAINER}" gitlab-rails runner "
username = '${USERNAME}'
email = '${EMAIL}'
password = '${PASSWORD}'

user = User.find_by_username(username)

if user.nil?
  admin_user = User.find_by_username('root') || User.admins.first

  params = {
    username: username,
    name: username,
    email: email,
    password: password,
    password_confirmation: password,
    admin: true,
    skip_confirmation: true
  }

  result = Users::CreateService.new(admin_user, params).execute

  if result.respond_to?(:persisted?) && result.persisted?
    user = result
    puts \"GitLab admin user created: #{username}\"
  else
    user = User.find_by_username(username)
    if user.nil?
      raise \"Could not create GitLab user #{username}\"
    end
  end
else
  puts \"GitLab user already exists: #{username}\"
end

user.password = password
user.password_confirmation = password
user.admin = true
user.skip_confirmation! if user.respond_to?(:skip_confirmation!)
user.save!

puts \"GitLab admin user ensured: #{username}\"
"
