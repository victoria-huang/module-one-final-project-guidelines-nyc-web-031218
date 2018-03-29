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
    new_password_validate

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
    new_username_validate
  else
    puts "\nThe password you entered is incorrect.\n"
    sleep(1)
    profile_methods
  end
end

def check_password_validity(password)
  check_string_case(password) && check_string_empty(password) && check_include_integer(password) && check_string_special(password)
end

def new_password_validate
  puts  "You must include at least one:
  \nspecial character, upper case letter, lower case letter, AND number"

  password = gets.strip
  if check_password_validity(password)
    @patient.password = password
    @patient.save
  else
    puts "Invalid password."
    puts "Please enter a new password.\n\n"
    new_password_validate
  end
end

def new_username_validate
  puts "\nPlease enter a new username between 5 and 20 characters:"
  new_username = gets.strip

  if new_username.length >= 5 && new_username.length <= 20
    @patient.name = new_username
    @patient.save
    puts "\nUsername changed!\n"
  elsif new_username.length < 5
    puts "\nSorry, that's too short."
    new_username_validate
  elsif new_username.length > 20
    puts "\nSorry, that's too long."
    new_username_validate
  end
  
  sleep(1)
  profile_methods
end
