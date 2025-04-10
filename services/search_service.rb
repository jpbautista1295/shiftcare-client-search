require "net/http"
require "json"

class SearchService
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
end
