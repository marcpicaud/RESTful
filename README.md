# Ruby REST application - School project
**Each steps of the project are committed into their own branch.**

==================

### Step 2
Connect your server with the MySQL table (a dump is available in users.sql)

The queries `GET /users/id` and `GET /user/id` should respond with the corresponding user without the password (JSON formatted).


To test it :

* `bundle install`
* `rackup --port 4567
* `curl -v http://your_ip:4567/users/id` or `curl http://your_ip:4567/user/id`


