require_relative '../config/environment'
require_relative 'menu'

def option_methods
  case menu
  when "1"
    full_drug_name = ""

    puts "Please enter the generic drug name (e.g., ibuprofen): "
    drug_name = gets.strip.downcase
    full_drug_name += drug_name

    puts "Please enter the drug dosage (e.g., 10 mg): "
    drug_dosage = gets.strip.downcase
    full_drug_name += " #{drug_dosage}"

    puts "Please enter the drug formulation (e.g., oral tablet)"
    drug_form = gets.strip.downcase
    full_drug_name += " #{drug_form}"

    puts "Please enter the doctor's name:"
    doctor_name = gets.strip

    $patient.add_drug(full_drug_name, doctor_name)
    option_methods
  when "2"
    patient.interactions = interactions_array
    #iterate through the interactions
    if interactions_array.length > 0
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
 when "3"
   $patient.prescriptions.each_with_index{|pres| puts "#{index+1}. #{pres.name}"
   puts }
 when "4"
 puts $patient.doctors.each_with_index{|doc| puts "#{index+1}. #{doc.name}"
 when "5"
   puts "please enter your reminder:"
   note = gets.strip
   $patient.add_reminder(note)
   puts "thank you"
   menu
 when "6"
   $patient.reminders.each_with_index{|note| puts "#{index+1}. #{note}"}
 end
end 
