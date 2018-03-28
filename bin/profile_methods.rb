require_relative '../config/environment'
require_relative 'main_menu_methods'
require_relative 'profile_menu'

def profile_methods
  case profile_menu
  when "1"
    #change username
    profile_methods
  when "2"
    #change password
    profile_methods
  when "3"
    main_menu_methods
  when "4"
    puts "\nGoodbye friend, thanks for checking in!"
  else
    puts "\nSorry, that is an invalid response."
    puts "Please enter a number from 1-4\n"
    profile_methods
  end
end
