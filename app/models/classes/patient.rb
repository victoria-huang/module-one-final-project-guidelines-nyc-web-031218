require 'bcrypt'
class Patient < ActiveRecord::Base
  has_secure_password
  has_many :prescriptions
  has_many :doctors, through: :prescriptions
  has_many :reminders

  def rxcui_array
    self.prescriptions.map{|prescription| prescription.rxcui}
  end

  def interactions
    rxcui_array = self.rxcui_array
    interactions = FindInteractionsApi.new(rxcui_array)

    if interactions.hash.keys.include?("fullInteractionTypeGroup")
      array_of_interactions = interactions.hash["fullInteractionTypeGroup"][0]["fullInteractionType"]

      interactions_array = array_of_interactions.map {|interaction| hash = Hash.new
        hash[:description] = interaction["interactionPair"][0]["description"]
        hash[:drug_1_name] = interaction["interactionPair"][0]["interactionConcept"][0]["minConceptItem"]["name"].downcase
        hash[:drug_2_name] = interaction["interactionPair"][0]["interactionConcept"][1]["minConceptItem"]["name"].downcase
        hash[:severity] = interaction["interactionPair"][0]["severity"]
        hash
      }
    else
      interactions_array = []
    end
  end

  def add_drug(drug_name, doctor_name)
    if Doctor.find_by(name: doctor_name)
      doctor = Doctor.find_by(name: doctor_name)
    else
      doctor = Doctor.create(name: doctor_name)
    end
    Prescription.find_or_create_with_rxcui(name: drug_name, doctor: doctor, patient: self)

      self.prescriptions.reload
  end

  def remove_drug(drug_index)
    prescriptions = self.prescriptions.uniq
    pres = Prescription.delete(prescriptions[drug_index].id)
  end

  def add_reminder(note)
    Reminder.find_or_create_by(note: note, patient: self)
  end
end

#  attr_accessor :password
#  attr_accessible :name, :email, :password, :password_confirmation
#  validates :password, :presence => true, :on => :create, :confirmation => true, :length => {:within => 6..12}
#  before_save :encrypt_password
#
#  def has_password?(submitted_password)
#    self.encrypted_password == Password.create(submitted_password)
# end
# private
#
#   def encrypt_password(submitted_password)
#        self.encrypted_password = has_password?(submitted_password)
#    end
# end
