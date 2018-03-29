require_relative '../../../config/environment'
require_relative 'main_menu_methods'
require_relative '../menus/profile_menu'

def profile_methods
  case profile_menu
  when "1"
    check_to_change_username
  when "2"
    check_to_change_password
  when "3"
    main_menu_methods
  else
    puts "\nSorry, that is an invalid response."
    puts "Please enter a number from 1-3\n\n"
    sleep(1)
    profile_methods
  end
end

def check_to_change_password
  puts "\nPlease enter your current password:"
  password = gets.strip

  if @patient.authenticate(password)
    puts "\nPlease enter a new password:"
    new_password = gets.strip
    @patient.password = new_password
    @patient.save
    puts "\nPassword changed!\n"
    sleep(1)
    profile_methods
  else
    puts "\nThe password you entered is incorrect.\n"
    sleep(1)
    profile_methods
  end
end

def check_to_change_username
  puts "\nPlease enter your current password:"
  password = gets.strip

  if @patient.authenticate(password)
    puts "\nPlease enter a new username:"
    new_username = gets.strip
    @patient.name = new_username
    @patient.save
    puts "\nUsername changed!\n"
    sleep(1)
    profile_methods
  else
    puts "\nThe password you entered is incorrect.\n"
    sleep(1)
    profile_methods
  end
end
