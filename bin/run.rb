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
name = gets.chomp
patient = Patient.find_or_create_by(name: name)
patient.save
patient.interactions = interactions_array
puts "What would you like to do?"
puts "choices:"
puts "1. add a prescription"
puts "2. check if existing prescriptions have any interactions"
puts "3. get a list of all your existing prescriptions"
puts "4. get a list of all your doctors' names"
puts "5. create a reminder"

response = gets.chomp
if response == "2"
    #iterate through the interactions
    interactions_array.each {|hash|
      if hash[:severity] != "N/A"
        puts "We found this interaction: "
        puts "#{hash[:description]}"
        puts "The severity of this interaction is #{hash[:severity]}."
        puts "Please notify doctors #{Doctor.find_by(prescription: Prescription.find_by(rxcui: hash[:drug_1_rxcui])).name}"
      else
        puts "We found this interaction: "
        puts "#{hash[:description]}"
        puts "The severity of this interaction is unknown by our database."
        #remember to store variables in yml
        puts "Please notify doctors #{Doctor.find_by(prescription: Prescription.find_by(rxcui: hash[:drug_1_rxcui])).name}"
      end
    }
   else
     puts "We found no interactions. Congrats!"
   end
