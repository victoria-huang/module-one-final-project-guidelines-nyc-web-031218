require_relative '../../../config/environment'
require_relative 'main_menu_methods'
require_relative '../menus/prescription_menu'

def prescription_methods
  case prescription_menu
  when "1"
    add_a_prescription
  when "2"
    remove_prescription
  when "3"
    prescriptions = @patient.prescriptions.reload.uniq
    if prescriptions.length > 0
      puts "\nHere all your prescription. Please type the number you would like to edit\n"

      prescriptions.each_with_index{|pres, index| puts "\n#{index+1}. #{pres.name}\n"}
      drug_index = gets.strip

      if check_string(drug_index) && prescriptions[drug_index.to_i - 1]
        edit_prescription(prescriptions[drug_index.to_i - 1])
      else
        puts "\nThat prescription does not exist in your records\n\n"
        sleep(1)
        prescription_methods
      end
    else
      puts "\nYou currently have no prescriptions!\n\n"
      sleep(1)
      prescription_methods
    end
  when "4"
    find_interactions
  when "5"
    list_prescriptions
  when "6"
    main_menu_methods
  else
    puts "\nSorry, that is an invalid response."
    puts "Please enter a number from 1-6\n\n"
    sleep(1)
    prescription_methods
  end
end

def add_a_prescription
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
  sleep(1)
  prescription_methods
end

def remove_prescription
  prescriptions = @patient.prescriptions.reload.uniq
  if prescriptions.length > 0
    puts "\nHere all your prescription. Please type the number you would like to remove\n"
    prescriptions.each_with_index{|pres, index| puts "\n#{index+1}. #{pres.name}\n"}
    drug_index = gets.strip

    if check_string(drug_index) && prescriptions[drug_index.to_i - 1]
      binding.pry
      @patient.remove_drug(drug_index.to_i - 1)
      prescriptions = @patient.prescriptions.reload.uniq
      puts "\nPrescription removed!\n"
      sleep(1)

      if prescriptions.length > 0
        puts "\nHere are your remaining prescriptions\n"
        sleep(1)
        prescriptions.each_with_index{|pres, index| puts "\n#{index+1}. #{pres.name}\n";
        sleep(0.5) }
      else
        puts "\nYou have no remaining prescriptions in our records\n"
      end
    else
      puts "\nThat prescription does not exist in your records\n\n"
    end
    continue?
    prescription_methods
  else
    puts "\nYou currently have no prescriptions!\n\n"
    sleep(1)
    prescription_methods
  end
end

def edit_prescription(prescription)
  puts "\nWhat would you like to edit?\n\n"
  puts "1. Drug dosage and formulation"
  puts "2. Doctor"

  response = gets.strip

  case response
  when "1"
    new_drug_name = prescription.name.split(" ")[0]

    puts "\nPlease enter new drug dosage:\n\n"
    dosage = gets.strip
    new_drug_name += " #{dosage}"

    puts "\nPlease enter new drug formulation:\n\n"
    formulation = gets.strip
    new_drug_name += " #{formulation}"

    prescription.name = new_drug_name
    prescription.save
    puts "\nDrug dosage and formulation updated!\n\n"
  when "2"
    puts "\nPlease enter new doctor name: \n\n"
    doctor_name = gets.strip
    new_doctor = Doctor.find_or_create_by(name: doctor_name)
    prescription.doctor = new_doctor
    prescription.save
    puts "\nDoctor name updated!\n\n"
  else
    puts "\nSorry, that is an invalid response."
    puts "Please enter a number from 1-2.\n\n"
    sleep(1)
    edit_prescription(prescription)
  end

  sleep(1)
  prescription_methods
end

def find_interactions
  @patient.prescriptions.reload
  interactions_array = @patient.interactions
  #iterate through the interactions
  if interactions_array.length > 0
    interactions_array.each {|hash|
      if Prescription.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0]
        if hash[:severity] != "N/A"
          puts "\nWe found this interaction:"
          sleep(1)
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
          sleep(1)
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
      sleep(7)
      }
   else
     puts "\nWe found no interactions. Congrats!\n\n"
     sleep(2)
   end

   prescription_methods
end

def list_prescriptions
  prescriptions = @patient.prescriptions.reload.uniq
  if prescriptions.length > 0
    puts "\nThese are your current prescriptions:"
    sleep(1)
    @patient.prescriptions.uniq.each_with_index{|pres, index| puts "\n#{index+1}. #{pres.name}\n";
    sleep(1)}
    prescription_methods
  else
    puts "\nYou currently have no prescriptions!\n\n"
    sleep(1)
    prescription_methods
  end
end
