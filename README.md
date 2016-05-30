# NFL Draft

## Initial Setup

* Clone the repo
* Setup the app

```
$ bundle install
$ rake db:migrate
```

* Rake Task - Following rake task loads the NFL team, player and draft order data into the database.

```
$ rake import:data
```

* Run the Server

```
$ rails s
```

## Other Rake Tasks
There is another rake task to simulate the draft process.

```
$ rake simulate:draft_process
```

## Running test cases

```
$ rspec
```



### Notes

