# README

## docker setup
`docker compose build`
`docker compose up`
`docker compose run rails bundle exec rake demo:setup`

## Manual testing
An easy way to test messages are auto loading, is to log in with another user using an incognito session, and send messages to tester@test.com

## Automated Tests
Run the rspec test suite with the following command
`docker compose build && docker compose run -e "RAILS_ENV=test" rails bundle exec rspec`