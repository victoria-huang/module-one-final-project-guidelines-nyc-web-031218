# require_relative 'interaction'
require 'pry'
class Prescription < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient
  # has_many :interactions
  # has_many :med2s, class_name: "Prescription", through: :interactions
  # has_many :med1s, class_name: "Prescription", through: :interactions
  #
  # def interacted_meds
  #   self.interactions.map do |i|
  #     if i.med1 == self
  #       i.med2
  #     else
  #       i.med1
  #     end
  #   end
  # end

  def get_drug_info
    name = self.name.split(" ")[0]
    client = FindDrugsApi.new.client
    drugs = client.call(:get_drugs, message: {name: name}).body[:multi_ref]
    drug_info_hash = drugs.find{|hash| hash.find{|key, value| key != :rx_concept && key == :cui}}
    # binding.pry
  end

  def get_drug_rxcui
    get_drug_info[:rxcui]
  end

  # def get_drug_info(name)
  #   name = name.split(" ")[0]
  #   client = FindDrugsApi.new.client
  #   drug = client.call(:get_drugs, message: {name: name})
  #   array = drug.body[:multi_ref]
  #   info_hash = array.select{|hash| hash.find{|key, value| key != :rx_concept && key == :cui}}
  #   binding.pry
  # end

  # def get_drug_rxcui(name)
  #   info_hash = get_drug_info(name)
  #   my_drug = info_hash.find{|hash| hash.find{|key, value| value.downcase == name}}
  #   my_drug[:rxcui]
  # end

  # def self.set_rxcui_for_all
  #   self.all.each{|prescription| prescription.rxcui = get_drug_rxcui(prescription.name)}
  # end

  def set_rxcui_for_new_drug
    self.rxcui = get_drug_rxcui
    self.save
    # binding.pry
  end

  def self.find_or_create_with_rxcui(attributes)
    if Prescription.find_by(attributes)
      puts "You have already added this drug"
      Prescription.find_by(attributes)
    else
      puts "Thank you for adding a new drug!"
      drug = Prescription.create(attributes) 
      drug.set_rxcui_for_new_drug
      drug
    end
  end
end
