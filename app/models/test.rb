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

# client = Test.new.client
# drug = client.call
#(:get_drugs, message: {name: "varenicline"})

# arr = drug.body[:multiref]
# arr[index][:rxcui] = number

# find first array with cui key --> arr.find { |hash|
# hash.find {|key, value| key == :cui}}
# end
