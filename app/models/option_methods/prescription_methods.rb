require_relative '../../../config/environment'
require_relative 'main_menu_methods'
require_relative '../menus/prescription_menu'

def prescription_methods
  case prescription_menu
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
    sleep(0.5)
    prescription_methods
  when "2"
    puts "\nHere are all your prescriptions. Please type the number you would like to remove\n"
    prescriptions = @patient.prescriptions.reload.uniq

    prescriptions.each_with_index{|pres, index| puts "\n#{index+1}. #{pres.name}\n"}
    drug_index = gets.strip.to_i - 1

    if check_string_empty(drug_index) && check_string_integer(drug_index) && prescriptions[drug_index]
      @patient.remove_drug(drug_index)
      prescriptions = @patient.prescriptions.reload.uniq
      puts "\nPrescription removed!\n"
      sleep(1)

      if prescriptions.length > 0
        puts "\nHere are your remaining prescriptions\n"
        sleep(1)
        prescriptions.each_with_index{|pres, index| puts "\n#{index+1}. #{pres.name}\n";
        sleep(0.5) }
      else
        puts "You have no remaining prescriptions in our records\n"
      end
    else
      puts "\nThat prescription does not exist in your records\n\n"
    end
    continue?
    prescription_methods
  when "3"
    @patient.prescriptions.reload
    interactions_array = @patient.interactions
    #iterate through the interactions
    if interactions_array.length > 0
      interactions_array.each {|hash| binding.pry
        if @patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0]
          if hash[:severity] != "N/A"
            puts "\nWe found this interaction:"
            sleep(1)
            puts "#{hash[:description]}"
            puts "The severity of this interaction is #{hash[:severity]}."
            if @patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor != @patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_2_name]}%")[0].doctor
              puts "Please consider notifying #{@patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor.name} and #{@patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_2_name]}%")[0].doctor.name}\n\n"
            else
              puts "Please consider notifying doctor(s) #{@patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor.name}"
            end
            # @patient.prescriptions.find_by(rxcui: hash[:drug_1_rxcui]).doctor.name
          else
            puts "\nWe found this interaction: "
            sleep(1)
            puts "#{hash[:description]}"
            puts "The severity of this interaction is unknown by our database."
            #remember to store variables in yml
            if @patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor != @patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_2_name]}%")[0].doctor
              puts "Please consider notifying doctors #{@patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor.name} and #{@patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_2_name]}%")[0].doctor.name}\n\n"
            else
              puts "Please consider notifying doctors #{@patient.prescriptions.where('name LIKE ?', "%#{hash[:drug_1_name]}%")[0].doctor.name}"
            end
          end
        end
        continue?
        }
     else
       puts "\nWe found no interactions. Congrats!\n\n"
       continue?
     end

     prescription_methods
  when "4"
    @patient.prescriptions.reload
    puts "These are your current prescriptions:"
    sleep(1)
    @patient.prescriptions.uniq.each_with_index{|pres, index| puts "\n#{index+1}. #{pres.name}\n";
    sleep(0.5)}
    continue?
    prescription_methods
  when "5"
    main_menu_methods
  else
    puts "\nSorry, that is an invalid response."
    puts "Please enter a number from 1-5\n"
    sleep(1)
    prescription_methods
  end
end
