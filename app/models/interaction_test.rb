require 'savon'
require 'rake'
require 'json'
require 'net/http'
require 'nokogiri'
require 'rest-client'

class InteractionTest
  attr_reader :client, :hash

  def initialize(rxcui_array)
    @client = RestClient.get('https://rxnav.nlm.nih.gov/REST/interaction/list.json?rxcuis='+rxcui_array.join("+"))
    @hash = JSON.parse(@client)
  end

  def self.interactions
    rxcui_array = self.rxcui_array
    interactions = InteractionTest.new(rxcui_array)
    array_of_interactions = interaction.hash["fullInteractionTypeGroup"][0]["fullInteractionType"]

    interactions_array = array_of_interactions.map {|interaction| hash = Hash.new
      hash[:description] = interaction["interactionPair"][0]["description"]
      hash[:drug_1_rxcui] = interaction["interactionPair"][0]["interactionConcept"][0]["minConceptItem"]["rxcui"]
      hash[:drug_2_rxcui] = interaction["interactionPair"][0]["interactionConcept"][1]["minConceptItem"]["rxcui"]
      hash[:severity] = interaction["interactionPair"][0]["severity"]
      hash
    }

  if interactions_array.any?{|hash| hash[:severity] != "N/A"}
      interactions_array.each {|hash|
        if hash[:severity] != "N/A"
          puts "We found this interaction: "
          puts "#{hash[:description]}"
          puts "The severity of this interaction is #{hash[:severity]}."
          puts "Please notify doctors #{Doctor.find_by(prescription: Prescription.find_by(rxcui: hash[:drug_1_rxcui])).name}"
        end
      }
   else
     puts "We found no interactions. Congrats!"
   end

    description = array_of_interactions[0]["interactionPair"][0]["description"]
    drug_1_rxcui = array_of_interactions[0]["interactionPair"][0]["interactionConcept"][0]["minConceptItem"]["rxcui"]
    drug_2_rxcui = array_of_interactions[0]["interactionPair"][0]["interactionConcept"][1]["minConceptItem"]["rxcui"]
    severity = array_of_interactions[0]["interactionPair"][0]["severity"]
  end
end

rxcui_array = [207106,152923,656659]

interaction = InteractionTest.new(rxcui_array)
array_of_interactions = interaction.hash["fullInteractionTypeGroup"][0]["fullInteractionType"]

description = array_of_interactions[0]["interactionPair"][0]["description"]
drug_1_rxcui = array_of_interactions[0]["interactionPair"][0]["interactionConcept"][0]["minConceptItem"]["rxcui"]
drug_2_rxcui = array_of_interactions[0]["interactionPair"][0]["interactionConcept"][1]["minConceptItem"]["rxcui"]
severity = array_of_interactions[0]["interactionPair"][0]["severity"]
