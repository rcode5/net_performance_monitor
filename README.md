# Network Performance Montior

This set of code uses `speedtest-cli` and `crontab` to take
periodic speed tests from your computer and provides a
graph of that data

This script uses S3 to store and retreive data.  You'll need to provide
it with the AWS enviroment keys:

```
AWS_ACCESS_KEY_ID=<key>
AWS_SECRET_ACCESS_KEY=<secret>
AWS_REGION=<region>
```
region is optional and defaults to `us-east-1`.

# Running the monitoring script

# Running the server

`rackup`

# Requirements

This was built on a Mac with Python and Ruby.  You'll need to get
`speedtest-cli` with a Python installer

``` pip install speedtest-cli ```
