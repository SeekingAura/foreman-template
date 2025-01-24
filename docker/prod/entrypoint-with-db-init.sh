#!/bin/bash
set -e

DB_STATUS="$(bundle exec bin/rake db:migrate:status 2>&1 | head -n 1)"
if [ "${HANDLE_FOREMAN_DB:-false}" == "true" ]; then
    if [ "$DB_STATUS" == "Schema migrations table does not exist yet."  ]; then
        echo "will init db now"
        bundle exec bin/rake db:migrate RAILS_ENV=production
        bundle exec bin/rake db:seed RAILS_ENV=production
        bundle exec bin/rake permissions:reset RAILS_ENV=production > /var/lib/foreman/.admin-default
        echo '##################_USERDATA_########################'
        cat /var/lib/foreman/.admin-default
        echo '##################_USERDATA_########################'
    else
        echo "db is already configured, starting up"
    fi
fi

export PATH=~/bin:${GEM_HOME}/bin:${PATH}

# Remove a potentially pre-existing server.pid for Rails.
rm -f ~/pids/server.pid

# update gems
bundle install

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"