require 'uri'
require 'net/http'
require 'google_custom_search_api'

class Agency
  attr_reader :name, :id, :website, :valid, :status, :seo, :suggestions

  def initialize(input)
    @id = input[:state_assigned_id]
    @name = input[:full_name]
    @website = input[:web_site]
    @valid = false
    @status = nil
    @seo = false
    @suggestions = []
    santize_website(@website)
  end

  def is_valid?(url)
    begin
      uri = URI.parse(url)
      uri.kind_of?(URI::HTTP)
    rescue URI::InvalidURIError
      false
    end
  end

  def santize_website(website)
    puts 'site:', website
    @valid = self.is_valid?(website)
    if @valid
      @website = @website
      check_status(@website)
    else
      # check_seo(@name)
    end
  end

  def check_status(website)
    begin
      uri = URI.parse(website)
      http = Net::HTTP.new(uri.host, uri.port)
      res = http.request(Net::HTTP::Get.new(uri.request_uri))
      @status = case res.code.to_i
               when 200 || 201
                 [:success]
               when (400..499)
                 [:bad_request]
               when (500..599)
                 [:server_problems]
               else
                 [res.code.to_i]
               end
    rescue SocketError => e
      puts "Exception: #{e}"
    end
    # check_seo(@name)
  end

  def check_seo(name)
    if !@valid then @seo = false end
    search_results = GoogleCustomSearchApi.search(name) 
  end
end