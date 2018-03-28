require_relative '../../../config/environment'
require_relative 'main_menu_methods'
require_relative '../menus/profile_menu'

def profile_methods
  case profile_menu
  when "1"
    #change username
    sleep(1)
    profile_methods
  when "2"
    #change password
    sleep(1)
    profile_methods
  when "3"
    main_menu_methods
  else
    puts "\nSorry, that is an invalid response."
    puts "Please enter a number from 1-3\n"
    sleep(1)
    profile_methods
  end
end
