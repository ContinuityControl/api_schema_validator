# API Schema Validator

This small app checks the schema of these gems:

[https://github.com/ContinuityControl/fdic](https://github.com/ContinuityControl/fdic)
[https://github.com/ContinuityControl/ncua](https://github.com/ContinuityControl/ncua)

It uses Redis and runs rake tasks daily with heroku scheduler

Here are the current statuses of the gems:
[![FDIC](http://cc-api-schema-validator.herokuapp.com/fdic/badge)](http://cc-api-schema-validator.herokuapp.com/fdic/status)
[![NCUA](http://cc-api-schema-validator.herokuapp.com/ncua/badge)](http://cc-api-schema-validator.herokuapp.com/ncua/status)


## Local setup


1. install redis - use your favorite package manager or [this link.](http://redis.io/download)
2. run `redis-server`
3. run `bundle`
4. run `REDIS_URL=redis://127.0.0.1:<your-redis-port> rake validate:fdic_schema validate:ncua_schema`
5. run `ruby ./app.rb`
6. ??
7. Profit!

## How it works

The app checks the schema of the [fdic](https://github.com/ContinuityControl/fdic) and [ncua](https://github.com/ContinuityControl/ncua) gems using their `.validate_schema!` methods.

It's running on [heroku](http://cc-api-schema-validator.herokuapp.com), but the root page doesn't do anything. Instead, the app exposes the following endpoints:

1. `/{fdic,ncua}/status` -> returns the JSON status of the fdic and ncua APIs in the following format:
```
{
  "schema_good" : true
}
// OR
{
  "schema_good" : false
}
```
2. `/{fdic,ncua}/badge` returns an svg status badge of the current state of the APIs. You saw these at the top of this README.

The app is scheduled to run daily at 4:00 UTC. It runs a series of rake tasks to hit the FDIC and NCUA APIs, test their status, and email our engineering team if either the APIs have changed or the app's versions of the gems in question are out of date.

feel free to play around with these rake tasks. Note that you need sendgrid credentials and some to and from email addresses passed in as arguments to the rake tasks.
```sh
$ rake -T
rake mail:if_gem_version_stale[to_email_address]  # test the current cached status, and email if it's bad
rake mail:if_schema_invalid[to_email_address]     # test the current cached status, and email if it's bad
rake validate:fdic_schema                         # test the FDIC's api
rake validate:ncua_schema                         # test the NCUA's api
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ContinuityControl/api_schema_validator.

## License

The code is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

