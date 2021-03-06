# Trip Adviser
## Setup Instruction
```
$ bundle install
$ bundle exec rake db:migrate
$ bundle exec rake db:seed_fu
$ bundle exec rails s
$ bundle exec sidekiq
```

### Redis is needed
You may also need Redis on local machine for rendering PV ranking and queuing background jobs. If you haven't install Redis, run
```
$ brew install redis
```
and run
```
$ redis-server
```
to start Redis.

## Sidekiq dashboard
You can monitor the background jobs through sidekiq dashboard. Start sidekiq
```
$ bundle exec sidekiq
```
and sign-in as Admin and go to ```root_url/sidekiq```.

## Testing
You can run rspec with guard. Temporary, it will run without ```Spring```.
```
$ bundle exec guard
```

## Sign In
As Admin (admins/sign_in)
```
email: admin@example.com
password: password
```

As User (users/sign_in)
```
email: user@example.com
password: password
```
