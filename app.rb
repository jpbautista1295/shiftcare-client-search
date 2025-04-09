require 'sinatra'
require 'sinatra/json'

require_relative 'services/search_service'

set :port, 3000

get '/query' do
  search_service = SearchService.new(params['search_field'], params['q'])

  json search_service.filter_results
end

get '/duplicates' do
  search_service = SearchService.new

  json search_service.check_duplicates
end