#!/bin/bash
set -e

DB_STATUS="$(foreman-rake db:migrate:status 2>&1 | head -n 1)"
if [ "$DB_STATUS" == "Schema migrations table does not exist yet."  ]; then
    echo "will init db now"
    foreman-rake db:migrate RAILS_ENV=production
    foreman-rake db:seed RAILS_ENV=production
    foreman-rake permissions:reset RAILS_ENV=production > /var/lib/foreman/.admin-default
    echo '##################_USERDATA_########################'
    cat /var/lib/foreman/.admin-default
    echo '##################_USERDATA_########################'
else
    echo "db is already configured, starting up"

fi

export PATH=~/bin:${GEM_HOME}/bin:${PATH}

# Remove a potentially pre-existing server.pid for Rails.
rm -f ~/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"