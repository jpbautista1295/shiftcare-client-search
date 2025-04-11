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
- `-r` / `--remote-url` : This option will allow users to indicate a URL that will be used as the dataset.

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

The endpoint above would search for entries with a full name that contains the word "davi".

##

- `http://localhost:3000/duplicates`: This endpoint will return duplicate emails in the dataset. You can also indicate some query parameters such as:

  - `remote_url` : This query parameter will allow users to indicate a URL that will be used as the dataset.

#### For example:

```
http://localhost:3000/duplicates?remote_url=https://someserver.com/clients.json
```

The endpoint above would search for duplicate entries given a custom JSON file as indicated on the remote URL query parameter.

## Assumptions

- The search field parameter can only accept three options: `id`, `full_name`, `email`. Any values other than those 3 would raise an exception.

- The `remote_url` parameter can only accept links that starts with `http://` or `https://` and ends with the `.json` extension. Otherwise, it would raise and exception.

- The `search_field` and `q` parameters on the filters would work with any valid JSON file. Provided that the data inside the `remote_url` contains the three fields (`id`, `full_name`, `email`).

- I went on with providing a REST application version of the app by using Sinatra. This will serve the two main features of the search service (`/query` and `/duplicates`).

- Basically, the REST application will function similarly to the CLI application. Provided that the proper parameters are indicated, as specified on the documentation I’ve provided above.

## Possible Improvements:

1. Add pagination and results per page option
2. Add a way to do exact search, string begins or ends with, etc. Similar to the `ransack` gem does it.
3. Add query objects instead of doing the logic to filter inside the search service.
4. Possibly provide a way to add more fields that can be filtered out if the JSON file provided in the remote_url parameter contains more than the initial fields (`id`, `full_name`, `email`) indicated.
5. Add a functional UI to possibly consume the API endpoints from Sinatra.
