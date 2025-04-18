require "optparse"

require_relative "lib/cli_commands"
require_relative "lib/exceptions/invalid_remote_url_error"
require_relative "services/search_service"

ARGV << "-h" if ARGV.empty?

options = {}

op = OptionParser.new do |opts|
  opts.banner = "Usage: cli.rb [options]"
  oc = CliCommands.new(opts, options)
  oc.load
end

begin
  op.parse!
rescue OptionParser::InvalidArgument => e
  puts e
  puts op.help
end

begin
  search_service = SearchService.new(options[:search_field], options[:query], options[:remote_url])
  results = options[:duplicate] ? search_service.check_duplicates : search_service.filter_results

  puts results
rescue InvalidRemoteUrlError => e
  puts "#{e.class.name}: #{e.message}"
end
