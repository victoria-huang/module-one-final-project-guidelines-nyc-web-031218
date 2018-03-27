require_relative 'config/environment'

# name = ""
# "please enter drug name"
# name += gets.chomp
# "please enter drug dosage"
# name += " " + gets.chomp
# "please enter whether it is tablet, capsule, chew, or patch"
# name += " " + gets.chomp
# Prescription.create(name)
# "would you like to see if any interactions exist between drugs? (y/n)"
# If gets.chomp == yes
# Prescription.interactions
puts "Welcome to the Prescription Organizer App!"
puts "please enter your full name:"
name = gets.strip
$patient = Patient.find_or_create_by(name: name)
$patient.save
option_methods 
