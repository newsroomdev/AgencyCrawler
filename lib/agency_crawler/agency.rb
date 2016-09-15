require 'uri'
require 'net/http'
require 'google_custom_search_api'
require 'typhoeus'

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
    p "#{@name}"
    p "#{website}"
    @valid = self.is_valid?(website)
    if @valid
      @website = @website
      check_status(@website)
    else
      # check_seo(@name)
    end
  end

  def check_status(website)
    req = Typhoeus.get(website, followlocation: true)
    @valid = req.success?
    @status = req.code
    p "  status: #{@status}"
    # check_seo(@name)
  end

  def check_seo(name)
    if !@valid then @seo = false end
    @search_results = GoogleCustomSearchApi.search(name) 
  end
end