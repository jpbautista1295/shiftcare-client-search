require "sinatra"
require "sinatra/json"

require_relative "lib/exceptions/invalid_remote_url_error"
require_relative "services/search_service"

set :port, 3000

get "/query" do
  search_service = SearchService.new(params["search_field"], params["q"], params["remote_url"])

  json search_service.filter_results
rescue InvalidRemoteUrlError, InvalidSearchFieldError => e
  halt 403, { "Content-Type" => "application/json" }, { errors: [e.message] }.to_json
end

get "/duplicates" do
  search_service = SearchService.new(nil, nil, params["remote_url"])

  json search_service.check_duplicates
end
