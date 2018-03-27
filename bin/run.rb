require_relative '../config/environment'
require_relative 'option_methods'

puts "Welcome to the Prescription Organizer App!"
puts "Please enter your full name:"
name = gets.strip
@patient = Patient.find_or_create_by(name: name)
@patient.save
option_methods
