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

def get_drug_info(name)
name = name.split(" ")[0]
client = Test.new.client
drug = client.call(:get_drugs, message: {name: name})
array = drug.body[:multi_ref]
info_hash = array.select{|hash| hash.find{|key, value| key != :rx_concept && key == :cui}}
end

def get_drug_rxcui(name)
info_hash = self.get_drug_info(name)
my_drug = info_hash.find{|hash| hash.find{|key, value| value.downcase == name}}
my_drug[:rxcui]
end

# def self.set_rxcui_for_all
#   self.all.each{|prescription| prescription.rxcui = get_drug_rxcui(prescription.name)}
# end

def set_rxcui_for_new_drug
prescription.rxcui = get_drug_rxcui(prescription.name
end

def self.create(name)
  drug = Prescription.new(name)
  drug.set_rxcui_for_new_drug(name)
end
name = ""
"please enter drug name"
name += gets.chomp
"please enter drug dosage"
name += " " + gets.chomp
"please enter whether it is tablet, capsule, chew, or patch"
name += " " + gets.chomp
Prescription.create(name)
"would you like to see if any interactions exist between drugs? (y/n)"
If gets.chomp == yes
Prescription.interactions

self.all.map{|prescription| prescription.rxcui}.join("+")


rxcui = drug.body[:multi_ref][2][:rxcui]
name = "varenicline 0.5 mg oral tablet"
