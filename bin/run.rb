require_relative '../config/environment'
require_relative 'main_menu_methods'

puts "Welcome to the Prescription Organizer App!"
puts "Please enter your full name:"
name = gets.strip
@patient = Patient.find_or_create_by(name: name)
@patient.save
main_menu_methods
