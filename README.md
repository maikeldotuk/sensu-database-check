# sensu-database-check

This is a very simple Redis, Mariadb and Mongo check of connectivity written in Python. To make it a single file I used Pyinstaller. 

## Why create another Redis check

The current ones I found here don't want to work so I created my own. Also I wanted to be able to run simple tests written in Python quickly. But I needed those tests to be able to call to external modules so I ended up using Pyinstaller to make the tests executable. 

If you want to use this repo as blueprint to build your own checks consider that in the build.sh file I use docker to build executables to the same machine specification of the Sensu alpine image. 

### To install 

```
sensuctl asset add maikeldotuk/sensu-database-check
```

Pass the next environment variables in your check config (eg: for Redis):

```
REDIS_HOST
REDIS_PORT (if ommited uses default)
REDIS_PASS 
```

To know what to pass to each test check the Python file of each one. They are self-explanatory

### Example configuration

```
type: CheckConfig
api_version: core/v2
metadata:
  name: check_redis
  namespace: default
spec:
  command: check_redis
  env_vars:
  - REDIS_HOST=YOUR_HOST_IP_OR_DNS_NAME
  - REDIS_PASS=YOUR_REDIS_PASS
  handlers:
  - slack
  interval: 60
  publish: true
  runtime_assets:
  - maikeldotuk/sensu-redis-simple-test
  subscriptions:
  - system
  timeout: 0
```