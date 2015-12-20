# Trip Adviser
## Setup Instruction
```
$ bundle install
$ bundle exec rake db:migrate
$ bundle exec rake db:seed_fu
$ bundle exec rails s
```

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
email: test@example.com
password: password
```
