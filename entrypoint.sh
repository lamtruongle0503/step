#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /step-travel/tmp/pids/server.pid

# Create db
# bundle exec rake db:create

# Run migrate
bundle exec rake db:migrate

# Run seed data
bundle exec rake db:seed_fu

# Get all permissions
bundle exec rake db:get_all_permissions

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
