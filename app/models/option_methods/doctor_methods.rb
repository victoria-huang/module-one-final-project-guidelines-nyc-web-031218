require_relative '../../../config/environment'
require_relative 'main_menu_methods'
require_relative '../menus/doctor_menu'

def doctor_methods
  case doctor_menu
  when "1"
    doctors = @patient.doctors.reload
    if doctors.length > 0
      puts "These are your current doctors:"
      sleep(1)
      @patient.doctors.uniq.each_with_index{|doc, index| puts "\n#{index+1}. #{doc.name}\n";
      sleep(1)}
      doctor_methods
    else
      puts "There are currently no doctors on file!"
      sleep(1)
      doctor_methods
    end
  when "2"
    main_menu_methods
  else
    puts "\nSorry, that is an invalid response."
    puts "Please enter a number from 1-2\n"
    sleep(1)
    doctor_methods
  end
end
