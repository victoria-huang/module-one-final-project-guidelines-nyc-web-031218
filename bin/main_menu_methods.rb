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
    main_menu_methods
  when "2"
    doctor_methods
    main_menu_methods
  when "3"
    reminder_methods
    main_menu_methods
  when "4"
    profile_methods
    main_menu_methods
  when "5"
    puts "\nGoodbye friend, thanks for checking in!"
  else
    puts "\nSorry, that is an invalid response."
    puts "Please enter a number from 1-5\n"
    main_menu_methods
  end
end
