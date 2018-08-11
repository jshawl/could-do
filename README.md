# Could Do

An .ics calendar feed for your recommended meetups.

## Local Development

Do the normal rails setup à la:

```
git clone https://github.com/jshawl/could-do.git
cd could-do
bundle install
rails db:create
rails db:migrate
rails s
```

### Add Credentials

At a minimum, you'll need to supply the following
environment variables with `rails credentials:edit`

```
meetup:
  client_id: yourclientidhere
  client_secret: yourclientsecrethere
  redirect_uri: http://localhost:3000/auth/callback #probably

hashids_salt: 'any string you want here'
```

You can obtain a client_id and client_secret by registering a new oauth consumer here: <https://secure.meetup.com/meetup_api/oauth_consumers/create>