## Setup

```
cd spec/dummy/
bundle exec rails railties:install:migrations
bundle exec rails db:migrate
bundle exec rails db:seed
```

Alternatively 
```
bundle exec rails console
>> load 'db/seed.rb'
```
Start the server 

```
bundle exec rails server -p 3005
```

## Usage

Get the subscription list of the given user (here User#1) 

```
curl -X GET \
  http://localhost:3000/users/1/subscriptions \
  -H 'Accept: application/vnd.api+json' \
  -H 'Content-Type: application/vnd.api+json' \
  -H 'cache-control: no-cache'
```

Subscribe the given user to a new list

```  
curl -X POST \
  http://localhost:3000/users/1/subscriptions/subscribe \
  -H 'Accept: application/vnd.api+json' \
  -H 'Content-Type: application/json' \
  -H 'cache-control: no-cache' \
  -d '{
  "data": {
    "attributes": {
      "list": "Whatever List"
    }
  }
}'
```

Unsubscribe to a list

```
curl -X DELETE \
  'http://localhost:3000/users/1/subscriptions/unsubscribe?list=Notification%20System' \
  -H 'Accept: application/vnd.api+json' \
  -H 'Content-Type: application/vnd.api+json' \
  -H 'cache-control: no-cache'
```
  
## Cleanup

find db/migrate/ -name '*mail_opt_out*' -exec rm {} \;
rm db/
rm db/development.sqlite3 
db/schema.rb 
rm -rf log/*
rm -rf tmp/*

