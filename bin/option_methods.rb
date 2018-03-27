require_relative '../config/environment'
require_relative 'menu'

def option_methods
  response = menu
  if [1..7].any?{|num| num == response}
    puts "\nIncorrect response"
  puts "Please enter a number from 1-7\n\n"
  option_methods
end

    case response
    when "1"
      full_drug_name = ""

      puts "\nPlease enter the generic drug name (e.g., ibuprofen): \n\n"
      drug_name = gets.strip.downcase
      full_drug_name += drug_name

      puts "\nPlease enter the drug dosage (e.g., 10 mg): \n\n"
      drug_dosage = gets.strip.downcase
      full_drug_name += " #{drug_dosage}"

      puts "\nPlease enter the drug formulation (e.g., oral tablet)\n\n"
      drug_form = gets.strip.downcase
      full_drug_name += " #{drug_form}"

      puts "\nPlease enter the doctor's name:\n\n"
      doctor_name = gets.strip

      @patient.add_drug(full_drug_name, doctor_name)
      option_methods
    when "2"
      interactions_array = @patient.interactions
      #iterate through the interactions
      if interactions_array.length > 0
        interactions_array.each {|hash|
          if hash[:severity] != "N/A"
            puts "\nWe found this interaction:"
            puts "#{hash[:description]}"
            puts "The severity of this interaction is #{hash[:severity]}."
            if Prescription.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor != Prescription.where('name LIKE ?', "%#{hash[:drug_2_name]}%")[0].doctor
            puts "Please notify #{Prescription.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor.name} and #{Prescription.where('name LIKE ?', "%#{hash[:drug_2_name]}%")[0].doctor.name}\n\n"
            else
              puts "Please notify doctor(s) #{Prescription.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor.name}"
            end
            # Prescription.find_by(rxcui: hash[:drug_1_rxcui]).doctor.name
          else
            puts "\nWe found this interaction: "
            puts "#{hash[:description]}"
            puts "The severity of this interaction is unknown by our database."
            #remember to store variables in yml
            if Prescription.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor != Prescription.where('name LIKE ?', "%#{hash[:drug_2_name]}%")[0].doctor
            puts "Please notify doctors #{Prescription.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor.name} and #{Prescription.where('name LIKE ?', "%#{hash[:drug_2_name]}%")[0].doctor.name}\n\n"
            else
              puts "Please notify doctors #{Prescription.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor.name}"
            end
          end
        }
     else
       puts "\nWe found no interactions. Congrats!\n\n"
     end
     option_methods
   when "3"
     @patient.prescriptions.uniq.each_with_index{|pres, index| puts "\n#{index+1}. #{pres.name}\n"}
     option_methods
   when "4"
     @patient.doctors
     @patient.doctors.uniq.each_with_index{|doc, index| puts "\n#{index+1}. #{doc.name}\n"}
     option_methods
   when "5"
     puts "\nplease enter your reminder:\n\n"
     note = gets.strip
     @patient.add_reminder(note)
     puts "\nthank you\n\n"
     option_methods
   when "6"
     @patient.reminders.uniq.each_with_index{|reminder, index| puts "\n#{index+1}. #{reminder.note}\n"}
     option_methods
   when "7"
     puts "\nGoodbye friend, thanks for checking in!"
     return
   end
end
