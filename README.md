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
4. run `REDIS_URL=redis://127.0.0.1:<your-redis-port> rake test_fdic test_ncua`
5. run `ruby ./app.rb`
6. ??
7. Profit!

To re-check the status of the APIs, run the rake tasks again with the `REDIS_URL` environment variable

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ContinuityControl/api_schema_validator.

## License

The code is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

