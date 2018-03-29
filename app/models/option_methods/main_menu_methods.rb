require_relative '../../../config/environment'
require_relative '../menus/main_menu'
require_relative 'prescription_methods'
require_relative 'doctor_methods'
require_relative 'reminder_methods'
require_relative 'profile_methods'

def main_menu_methods
  case main_menu
  when "1"
    prescription_methods
  when "2"
    doctor_methods
  when "3"
    reminder_methods
  when "4"
    profile_methods
  when "5"
    puts "\nGoodbye friend, thanks for checking in!"
  else
    puts "\nSorry, that is an invalid response."
    puts "Please enter a number from 1-5\n\n"
    sleep(1)
    main_menu_methods
  end
end
