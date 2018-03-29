require_relative '../../../config/environment'
require_relative 'main_menu_methods'
require_relative '../menus/prescription_menu'
require_relative '../classes/find_drugs_api'

def prescription_methods
  case prescription_menu
  when "1"
    add_a_prescription
  when "2"
    remove_prescription
  when "3"
    prescriptions = @patient.prescriptions.reload.uniq
    if prescriptions.length > 0
      puts "\nHere are all your prescriptions. Please type the number you would like to edit\n"

      prescriptions.each_with_index{|pres, index| puts "\n#{index+1}. #{pres.name}\n"}
      drug_index = gets.strip

      if check_string_empty(drug_index) && prescriptions[drug_index.to_i - 1] && check_string_integer(drug_index)
        edit_prescription(prescriptions[drug_index.to_i - 1])
      else
        puts "\nThat prescription does not exist in your records\n\n"
        sleep(1)
        prescription_methods
      end
    else
      puts "\nYou currently have no prescriptions!\n\n"
      continue?
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
  client = FindDrugsApi.new.client
  if Prescription.validate_drug(drug_name, client)
  puts "\nPlease enter the drug dosage (e.g., 10 mg): \n\n"
  drug_dosage = gets.strip.downcase
  full_drug_name += " #{drug_dosage}"

  puts "\nPlease enter the drug formulation (e.g., oral tablet)\n\n"
  drug_form = gets.strip.downcase
  full_drug_name += " #{drug_form}"

  puts "\nPlease enter the doctor's name:\n\n"
  doctor_name = gets.strip
  @patient.add_drug(full_drug_name, doctor_name)
    continue?
    prescription_methods
  else
    puts "\nSorry, we unfortunately do not track this medication in our database.
      \nPlease check your spelling and try again.\n\n"
      continue?
      prescription_methods
  end
end

def remove_prescription
  prescriptions = @patient.prescriptions.reload.uniq
  if prescriptions.length > 0
    puts "\nHere are all your prescriptions. Please type the number you would like to remove\n"
    prescriptions.each_with_index{|pres, index| puts "\n#{index+1}. #{pres.name}\n"}
    drug_index = gets.strip

    if check_string_empty(drug_index) && prescriptions[drug_index.to_i - 1] && check_string_integer(drug_index)
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
    continue?
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

  continue?
  prescription_methods
end

def find_interactions
  boolean = false
  boolean1 = false
  @patient.prescriptions.reload
  interactions_array = @patient.interactions
  #iterate through the interactions
  if interactions_array.length > 0
    interactions_array.each {|hash|
      if @patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0] && @patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_2_name]}%")[0]
        boolean1 = true
        if !hash.keys.include?(:severity)
          message_if_unknown(hash)
          #remember to store variables in yml
          interaction_message(hash)
        elsif hash[:severity] != "N/A"
          puts "\nWe found this interaction:"
          sleep(1)
          puts "#{hash[:description]}"
          puts "The severity of this interaction is #{hash[:severity]}."
          interaction_message(hash)
          # @patient.prescriptions.find_by(rxcui: hash[:drug_1_rxcui]).doctor.name
        else
          message_if_unknown(hash)
          #remember to store variables in yml
          interaction_message(hash)
        end

      else
         boolean = true
      end
      }
    if boolean && !boolean1
      puts "\nWe found no interactions. Congrats!\n\n"
    end
    continue?
    prescription_methods
   else
    puts "\nWe found no interactions. Congrats!\n\n"
    continue?
    prescription_methods
   end
end

def message_if_unknown(hash)
  puts "\nWe found this interaction: "
  sleep(1)
  puts "#{hash[:description]}"
  puts "The severity of this interaction is unknown by our database."
end
def interaction_message(hash)
  if @patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor != @patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_2_name]}%")[0].doctor
    puts "Please consider notifying doctor(s) #{@patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor.name} and #{@patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_2_name]}%")[0].doctor.name}\n\n"
  else
    puts "Please consider notifying doctor(s) #{@patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor.name}"
  end
end

def list_prescriptions
  prescriptions = @patient.prescriptions.reload.uniq
  if prescriptions.length > 0
    puts "\nThese are your current prescriptions:"
    sleep(1)
    @patient.prescriptions.uniq.each_with_index{|pres, index| puts "\n#{index+1}. #{pres.name}\n";
    sleep(0.5)}
    continue?
    prescription_methods
  else
    puts "\nYou currently have no prescriptions!\n\n"
    continue?
    prescription_methods
  end
end
