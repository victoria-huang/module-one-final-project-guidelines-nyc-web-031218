require 'savon'
require 'rake'
require 'json'
require 'net/http'
require 'nokogiri'

class Test
  attr_reader :client

  def initialize
    @client = Savon.client(
      wsdl: "https://rxnav.nlm.nih.gov/RxNormDBService.xml",
    )
  end
end
