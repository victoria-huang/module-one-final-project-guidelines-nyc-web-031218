require 'savon'
require 'rake'
require 'json'
require 'net/http'
require 'nokogiri'
require 'rest-client'

class FindInteractionsApi
  attr_reader :client, :hash

  def initialize(rxcui_array)
    @client = RestClient.get('https://rxnav.nlm.nih.gov/REST/interaction/list.json?rxcuis='+rxcui_array.join("+"))
    @hash = JSON.parse(@client)
  end
end

# rxcui_array = [207106,152923,656659]
