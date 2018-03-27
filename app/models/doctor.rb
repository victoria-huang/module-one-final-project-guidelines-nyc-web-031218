class Doctor < ActiveRecord::Base
  has_many :prescriptions
  has_many :patients, through: :prescriptions
  # validates_uniqueness_of :id
  validates_uniqueness_of :name
end
