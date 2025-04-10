require "optparse"

class CliCommands
  def initialize(parser_options, cli_options)
    @parser_options = parser_options
    @cli_options = cli_options
  end

  def add_search_field
    search_field_options = ["email", "full_name", "id"]
    search_field_desc = "The search field that will be used for the search. Available options: #{search_field_options}"

    @parser_options.on("-s", "--search-field SEARCH_FIELD", search_field_desc, search_field_options) do |sf|
      @cli_options[:search_field] = sf
    end
  end

  def add_search_query
    query_desc = "The search term that will be used."
    @parser_options.on("-q", "--query QUERY", query_desc, String) do |q|
      @cli_options[:query] = q
    end
  end

  def add_duplicate
    duplicate_desc = "This option will search (and return) duplicate emails in the dataset."
    @parser_options.on("-d", "--duplicate", duplicate_desc) do |d|
      @cli_options[:duplicate] = d
    end
  end

  def add_remote_url
    remote_url_desc = "This option will allow users to indicate a URL that will be used as the dataset."
    @parser_options.on("-r", "--remote-url REMOTE_URL", remote_url_desc) do |r|
      @cli_options[:remote_url] = r
    end
  end

  def load
    add_search_field
    add_search_query
    add_duplicate
    add_remote_url
  end
end
