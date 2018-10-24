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

You can run it with `crontab` by updating your cron file to include something like

```
*/30 * * * * . /path_to_repo/config/cron_environment.sh && /usr/local/bin/rbenv exec ruby /path_to_repo/script/record_net_performance.rb -b net-performance -d s3_directory_for_data_files -O s3
```

This runs the script every 30 minutes (assuming you're using `rbenv` for your ruby version management).  Your mileage may vary.

There is a sample file under `config/cron_environment.sh`.  You may notice that the `PATH` has been augmented.  In recent versions of MacOS, it seems that `md5` is in the `/sbin` directory so this path modification makes that available.  Your mileage may vary (read: may not need this).


# Running the server

`foreman start -f Procfile.dev`

For the server to work with the S3 bucket, you must enable CORS on that bucket.  See  http://docs.aws.amazon.com/AmazonS3/latest/user-guide/add-cors-configuration.html

Your configuration should look something like

```
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
  <CORSRule>
    <AllowedOrigin>*</AllowedOrigin>
    <AllowedMethod>GET</AllowedMethod>
    <MaxAgeSeconds>3000</MaxAgeSeconds>
    <AllowedHeader>*</AllowedHeader>
  </CORSRule>
</CORSConfiguration>
```

# Requirements

This was built on a Mac with Python and Ruby.  You'll need to get
`speedtest-cli` with a Python installer

``` pip install speedtest-cli ```
