# Shiftcare Technical Exam

## How to run CLI application

On your command line, type in:

```
ruby cli.rb [options]
```

### Available Options:

- `-s` / `--search-field` : The search field that will be used for the search. **Available options**: `email`, `full_name`, `id`
- `-q` / `--query` : The search term that will be used.
- `-d` / `--duplicate` : This option will search (and return) duplicate emails in the dataset.
- `-r` / `--remote_url` : This option will allow users to indicate a URL that will be used as the dataset.

### For example:

```
ruby cli.rb -s "email" -q "gmail"
```

The command above would search for entries with an email that contains the word "gmail".

## How to run REST application (via Sinatra)

1. On your command line, install the required gems using the command:

```
bundle install
```

2. After installing the required gems, boot up the app using the command:

```
ruby app.rb
```

---

## Available Endpoints

- `http://localhost:3000/query`: This would display all records or filter out the records provided that the query parameters are used:

  - `search_field` : The search field that will be used for the search. **Available options**: `email`, `full_name`, `id`

  - `q` : The search term that will be used.

  - `remote_url` : This query parameter will allow users to indicate a URL that will be used as the dataset.

#### For example:

```
http://localhost:3000/query?search_field=full_name&q=davi
```

The command above would search for entries with a full name that contains the word "davi".

##

- `http://localhost:3000/duplicates`: This endpoint will return duplicate emails in the dataset. You can also indicate some query parameters such as:

  - `remote_url` : This query parameter will allow users to indicate a URL that will be used as the dataset.
