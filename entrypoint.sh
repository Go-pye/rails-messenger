#!/bin/sh

# Note: !/bin/sh must be at the top of the line,
# Alpine doesn't have bash so we need to use shell.
# Docker entrypoint script.
# Don't forget to give this file execution rights via `chmod +x entrypoint.sh`
# which I've added to the Dockerfile but you could do this manually instead.

# Wait until Postgres is ready before running the next step.
while ! pg_isready -q -h $DB_HOST -p $DB_PORT -U postgres
do
  echo "$(date) - waiting for database to start."
  sleep 2
done

# Create the database if it doesn't exist
echo "Creating database if it doesn't exist..."
bundle exec rails db:create

# Always run migrations
echo "Running database migrations..."
bundle exec rails db:migrate

# Remove a potentially pre-existing server.pid for Rails.
echo "Deleting server.pid file..."
rm -f /tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
