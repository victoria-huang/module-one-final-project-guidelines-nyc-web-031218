require 'savon'
require 'rake'
require 'json'
require 'net/http'
require 'nokogiri'

class FindDrugsApi
  attr_reader :client

  def initialize
    @client = Savon.client(
      wsdl: "https://rxnav.nlm.nih.gov/RxNormDBService.xml",
    )
  end
end


# self.all.map{|prescription| prescription.rxcui}.join("+")
#
#
# rxcui = drug.body[:multi_ref][2][:rxcui]
# name = "varenicline 0.5 mg oral tablet"
