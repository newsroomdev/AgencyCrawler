require 'csv'
require_relative './agency_crawler/agency.rb'

# + read the csv hash
# + check for URL in each row
# + filter agencies: has_url, hasnt_url
#   + has_url
#     + has_status
#       + has_top_five
#       + hasnt_top_five
#     + hasnt_status
#   + hasnt_url
#
#
# use different scripts
# unix-style one thing at a time
#   think of isolating
#   "data flow" ~ React
# ruby gem for renaming
#   rubocop

class AgencyCrawler
  attr_reader :agencies

  def initialize(input)
    load_csv(input)
  end

  def load_csv(input)
    # load a CSV containing urls and agency names
    file = input.respond_to?(:readline) ? input : File.open(input)
    agencies_csv = CSV.new(file, headers: true, header_converters: :symbol, converters: :all)
    @agencies = agencies_csv.to_a.map{|agency| Agency.new(agency)}
  end

  def write_csv(input)
    CSV.open(input, 'w') do |csv_object|
      @agencies_hash.each do |row_array|
        csv_object << row_array
      end
    end
  end
end