require_relative '../config/environment'
require_relative 'main_menu'
require_relative 'prescription_menu'
require_relative 'doctor_menu'
require_relative 'reminder_menu'
require_relative 'profile_menu'

def main_menu_methods
  case main_menu
  when "1"
    prescription_methods
    option_methods
  when "2"
    doctor_menu
    option_methods
  when "3"
    reminder_menu
    option_methods
  when "4"
    profile_menu
    option_methods
  when "5"
    puts "\nGoodbye friend, thanks for checking in!"
  else
    puts "\nSorry, that is an invalid response."
    puts "Please enter a number from 1-5\n"
    option_methods
  end
end



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
    puts "\nHere all your prescription. Please type the number you would like to remove\n\n"
    prescriptions = @patient.prescriptions.reload.uniq

    prescriptions.each_with_index{|pres, index| puts "\n#{index+1}. #{pres.name}\n"}
    drug_index = gets.strip.to_i - 1
    if prescriptions[drug_index]
    @patient.remove_drug(drug_index)
    prescriptions = @patient.prescriptions.reload.uniq
    puts "Prescription removed"
    if prescriptions.length > 0
    puts "Here are your remaining prescriptions\n"
    prescriptions.each_with_index{|pres, index| puts "\n#{index+1}. #{pres.name}\n"}
    else
      puts "You have no remaining prescriptions in our records\n"
    end
  else
    puts "\nThat prescription does not exist in your records\n\n"
  end
    option_methods
  when "3"
    @patient.prescriptions.reload
    interactions_array = @patient.interactions
    #iterate through the interactions
    if interactions_array.length > 0
      interactions_array.each {|hash|
        if Prescription.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0]
          if hash[:severity] != "N/A"
            puts "\nWe found this interaction:"
            puts "#{hash[:description]}"
            puts "The severity of this interaction is #{hash[:severity]}."
            if Prescription.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor != Prescription.where('name LIKE ?', "%#{hash[:drug_2_name]}%")[0].doctor
              puts "Please consider notifying #{Prescription.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor.name} and #{Prescription.where('name LIKE ?', "%#{hash[:drug_2_name]}%")[0].doctor.name}\n\n"
            else
              puts "Please consider notifying doctor(s) #{Prescription.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor.name}"
            end
            # Prescription.find_by(rxcui: hash[:drug_1_rxcui]).doctor.name
          else
            puts "\nWe found this interaction: "
            puts "#{hash[:description]}"
            puts "The severity of this interaction is unknown by our database."
            #remember to store variables in yml
            if Prescription.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor != Prescription.where('name LIKE ?', "%#{hash[:drug_2_name]}%")[0].doctor
              puts "Please consider notifying doctors #{Prescription.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor.name} and #{Prescription.where('name LIKE ?', "%#{hash[:drug_2_name]}%")[0].doctor.name}\n\n"
            else
              puts "Please consider notifying doctors #{Prescription.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor.name}"
            end
          end
        end
        }
     else
       puts "\nWe found no interactions. Congrats!\n\n"
     end
    option_methods
  when "4"
    @patient.prescriptions.reload
    @patient.prescriptions.uniq.each_with_index{|pres, index| puts "\n#{index+1}. #{pres.name}\n"}
    option_methods
  when "5"
    @patient.doctors.reload
    @patient.doctors.uniq.each_with_index{|doc, index| puts "\n#{index+1}. #{doc.name}\n"}
    option_methods
  when "6"
    puts "\nPlease enter your reminder:\n\n"
    note = gets.strip
    # VICKY: remember to add menu/control options later!!!
    if note == 'Q' || note =='q'
      options_methods
    else
      @patient.add_reminder(note)
      puts "\nThank you for adding a reminder!\n\n"
    end

    option_methods
  when "7"
    @patient.reminders.reload
    @patient.reminders.uniq.each_with_index{|reminder, index| puts "\n#{index+1}. #{reminder.note}\n"}
    option_methods
  when "8"
    puts "\nGoodbye friend, thanks for checking in!"
    # return - VICKY: removed as it was not needed to exit the program (not calling function again anyways)
else
  puts "\nSorry, that is an invalid response."
  puts "Please enter a number from 1-7\n"
  option_methods
end
end