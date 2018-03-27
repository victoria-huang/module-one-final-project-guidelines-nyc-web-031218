# require_relative 'interaction'

class Prescription < ActiveRecord::Base
  has_many :interactions
  has_many :med2s, class_name: "Prescription", through: :interactions
  has_many :med1s, class_name: "Prescription", through: :interactions

  def interacted_meds
    self.interactions.map do |i|
      if i.med1 == self
        i.med2
      else
        i.med1
      end
    end
  end
end
