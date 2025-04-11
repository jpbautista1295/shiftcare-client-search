require "net/http"
require "json"

require "./lib/exceptions/invalid_remote_url_error"
require "./lib/exceptions/invalid_search_field_error"

class SearchService
  REMOTE_URL_REGEX = /^https?:\/\/.*\.json$/
  SAMPLE_FILE_PATH = "./data/clients.json"

  def initialize(search_field = nil, query = nil, remote_url = nil)
    @search_field = search_field
    @query = query
    @remote_url = remote_url
    @results = fetch_results
  end

  def fetch_results
    if @remote_url
      puts "Reading JSON file from: #{@remote_url}"

      check_remote_url_pattern

      response = Net::HTTP.get_response(URI.parse(@remote_url))

      JSON.parse(response.body)
    else
      puts "Reading JSON file from: #{SAMPLE_FILE_PATH}"
      file = File.read(SAMPLE_FILE_PATH)

      JSON.parse(file)
    end
  end

  def filter_results
    return @results if @search_field == nil || @query == nil

    check_search_field

    @results.select do |result|
      if result[@search_field.to_s]
        if @search_field.to_s != "id"
          result[@search_field.to_s].downcase.include?(@query.downcase)
        else
          result[@search_field.to_s].to_i == @query.to_i
        end
      else
        true
      end
    end
  end

  def check_duplicates
    result_emails = @results.map { |result| result["email"] }

    @results.select { |result| result_emails.count(result["email"]) > 1 }
  end

  private
    def check_remote_url_pattern
      raise InvalidRemoteUrlError unless REMOTE_URL_REGEX.match?(@remote_url)
    end

    def check_search_field
      raise InvalidSearchFieldError unless %w[email full_name id].include?(@search_field)
    end
end
