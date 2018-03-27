def methods
  response = menu
case response

when "2"
    #iterate through the interactions
    interactions_array = $patient.interactions
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
