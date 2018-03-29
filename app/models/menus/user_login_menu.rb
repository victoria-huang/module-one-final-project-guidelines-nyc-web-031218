require_relative '../../../config/environment'
require_relative '../option_methods/main_menu_methods'

def user_login_menu
  puts "Do you already have an account? (y/n)"
  login
end

def login
  answer = gets.strip.downcase

  case answer
  when "y",  "yes"
    puts "\nGreat!"
    login_to_account
  when "n", "no"
    puts "\nOk, creating a new account is easy!"
    create_an_account
  else
    puts "\nInvalid response."
    puts "Please enter yes or no."
    login
  end
end

def login_to_account
  puts "\nPlease enter your username:"
  name = gets.strip

  if Patient.find_by(name: name)
    @patient = Patient.find_by(name: name)
    password_authenticate
  else
    puts "\nThe account you entered doesn't exist."
    incorrect_login
  end
end

def create_an_account
  puts "\nPlease enter a new username:"
  puts "(must be between 5 and 20 characters)"
  name = gets.strip

  if !Patient.find_by(name: name) && name.length >= 5 && name.length <= 20
    @patient = Patient.create(name: name)
    @patient.save
    puts "\nHello, #{@patient.name.split(" ")[0]}"
    puts "Please choose a password:"
    new_password_validate
    puts "\nThank you! Would you like to log in now? (y/n)"
    choices_after_account_creation
  elsif name.length < 5
    puts "\nSorry, that's too short."
    create_an_account
  elsif name.length > 20
    puts "\nSorry, that's too long."
    create_an_account
  else
    puts "\nSorry, that username is taken."
    puts "You must choose a unique username."
    create_an_account
  end
end

def check_password_validity(password)
  check_string_case(password) && check_string_empty(password) && check_include_integer(password) && check_string_special(password)
end

def new_password_validate
  puts  "You must include at least one:
  \nspecial character, upper case letter, lower case letter, AND number"

  password = gets.strip
  puts "You must include at least one: \nspecial character, upper case letter, lower case letter, AND integer"
  if check_password_validity(password)
    @patient.password = password
    @patient.save
  else
    puts "Invalid password."
    puts "Please enter a new password.\n\n"
    new_password_validate
  end
end

def incorrect_login
  puts "Please choose one:"
  puts "1. Try again"
  puts "2. Create a new account\n\n"

  choice = gets.strip

  case choice
  when "1"
    user_login_menu
  when "2"
    create_an_account
  else
    puts "\nInvalid response:"
    puts "Please enter 1 or 2.\n\n"
    incorrect_login
  end
end

def choices_after_account_creation
  open_or_not = gets.strip.downcase

  case open_or_not
  when "y", "yes"
    main_menu_methods
  when "n", "no"
    puts "\nThank you for creating an account. See you soon!"
  else
    puts "\nInvalid response:"
    puts "Please enter yes or no."
    choices_after_account_creation
  end
end

def password_authenticate
  puts "\nPlease enter your password:"
  password = gets.strip
  if @patient.authenticate(password)
    sleep(0.5)
    puts "\n\nWelcome #{@patient.name.split(" ")[0]}"
    main_menu_methods
  else
    puts "\nThe password you entered is incorrect"
    puts "Please choose one:"
    puts "1. Try again"
    puts "2. Create a new account"

    validate_password_response
  end
end

def validate_password_response
  choice = gets.strip
  case choice
  when "1"
    password_authenticate
  when "2"
    create_an_account
  else
    puts "\nInvalid response:"
    puts "Please enter 1 or 2."
    validate_password_response
  end
end
