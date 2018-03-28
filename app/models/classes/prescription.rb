# require_relative 'interaction'
require 'pry'

class Prescription < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient

  #=====================>CREATION PROCESS CHAIN<======================#
  #First
  #This method is only called inside Patient.add_drug method
  def self.find_or_create_with_rxcui(attributes)
    #Check if the prescription already exists
    if Prescription.find_by(attributes)
      puts "\nYou have already added this drug\n\n"
      Prescription.find_by(attributes)
    else
      #If the prescription doesn't exist, run validate_or_create to:
      #1. Call the drugs API
      #2. Check if this drug is a valid API call
      #3. If it's a valid API call, then create Prescription instance
      #4. Associate the rxcui returned by the drug API with the new Prescription instance
      validate_or_create_drug(attributes)
    end
  end
  #Second
  def self.validate_or_create_drug(attributes)
    client = FindDrugsApi.new.client
      #Validate whether drug name exists in API
    if validate_drug(attributes[:name], client)
      #If drug name exists in API:
      #1. Create a new prescription instance
      #2. Associate the rxcui returned by API to the new prescription
      puts "\nThank you for adding a new drug!\n\n"
      drug = Prescription.create(attributes)
      drug.set_rxcui_for_new_drug(client)
      drug
    else
      puts "\nSorry, that is not a valid drug name!\n\n"
    end
  end
  #Third (condition)
  #1. Get just the drug name (without dosage) from the Prescription instance
  #2. Validate if drug exists in API through the client
  def self.validate_drug(name, client)
    split_name = name.split(" ")[0]
    client.call(:get_drugs, message: {name: split_name}).body[:multi_ref]
  end
  #Fourth
  #1. Calls get_drug_rxcui to retrieve rxcui associated with the drug from the client
  #2. Sets the rxcui to the prescription instance and saves the instance
  def set_rxcui_for_new_drug(client)
    self.rxcui = get_drug_rxcui(client)
    self.save
  end
  #Fifth
  #1. Calls get_drug_info to retrieve a hash of the drug info
  #associated with the drug name from the client
  #2. Uses rxcui key to obtain rxcui number (as a string)
  #3. Calls #to_i to transform string into an integer
  def get_drug_rxcui(client)
    get_drug_info(client)[:rxcui].to_i
  end
  #Sixth
  #1. Get just the drug name (without dosage) from the Prescription instance
  #2. Retrieves a hash of the drug info associated with the drug name from the client
  def get_drug_info(client)
    name = self.name.split(" ")[0]
    drugs = client.call(:get_drugs, message: {name: name}).body[:multi_ref]
    drug_info_hash = drugs.find{|hash| hash.find{|key, value| key != :rx_concept && key == :cui}}
  end
end

# =======>VICKY: Delete comments below if not needed anymore<=======
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

# elsif validate_drug(attributes[:name])
#
# else
#   puts "\nThank you for adding a new drug!\n\n"
#   drug = Prescription.create(attributes)
#   drug.set_rxcui_for_new_drug
#   drug

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
