### NFL Draft


Clone the repo
Setup the app

```
bundle install
rake db:migrate
```


Rake task to load the data from CSV files

```
rake import:data
```

Run the Server

```
rails s
```


Rake task to simulate the Draft process.

```
$ rake import:data
$ rake simulate:draft_process
```

Running test cases

```
$ rspec
```
