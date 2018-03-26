require_relative 'prescription'

class Interaction < ActiveRecord::Base
  belongs_to :med1, class_name: "Prescription"
  belongs_to :med2, class_name: "Prescription"

  def self.interactions(med)
    self.all.select{|med1| med1.med1_id == med.id}
  end
end
