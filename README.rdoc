== README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
ruby 2.2.1p85

* System dependencies

* Configuration

* Database creation
rake db:migrate

* Database initialization
rake import:data

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.

# NFL Draft

## Initial Setup

1. Clone the repo
2. Setup the app

```
$ bundle install
$ rake db:migrate
```

3. Rake Task
The following rake task loads the NFL team, player and draft order data into the database.

```
$ rake import:data
```

3. Run the Server

```
$ rails s
```

## Other Rake Tasks
There is another rake task to simulate the draft process.

```
$ rake simulate:draft_process
```

## Running test cases


### Notes

