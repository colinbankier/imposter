# Imposter

To start your new Phoenix application:

1. Install dependencies with `mix deps.get`
2. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Run locally

Ensure that PSQL is running

Install dependencies

```sh
mix deps.get
```

Install node dependencies

```sh
npm install
```

Run tests
```sh
mix test
```

Start Server
```sh
mix phoenix.server
```

## Create Routes

Create a Route Example
```sh
POST localhost:4000/_routes
Content-Type: application/json
{
  "method": "GET",
  "path": "/baz",
  "response": {
    "body": "{\"foo\":\"this is a get\"}"
  }
}
```

View all Routes Example
```sh
GET localhost:4000/_routes
```

Delete all Routes
```sh
DELETE localhost:4000/_routes
```

View a particular route
```sh
GET localhost:4000/baz
```

##View Request History

View all Requests
```sh
GET localhost:4000/_request_history
```

View a particular Request
```sh
GET localhost:4000/_request_history/0
```

Delete all requests
```sh
DELETE localhost:4000/_request_history
```
