require_relative '../../config/environment'
require_relative '../menu'

def user_login_menu
  puts "Do you already have an account? (y/n)"
  answer = gets.strip.downcase
  login(answer)
end

def login(answer)
    case answer
    when "y",  "yes"
        puts "Great!"
        puts "Please enter your full name:"
        name = gets.strip
        if Patient.find_by(name: name)
          @patient = Patient.find_by(name: name)
          password_authenticate
        else
          puts "The account you entered doesn't exist."
          puts "Please choose one:\n"
          puts "1: Try again\n"
          puts "2: Create a new account\n"
          choice = gets.strip
          case choice
            when "1"
              login(answer)
            when "2"
              create_an_account
          end
        end
      when "n", "no"
        puts "Ok, creating a new account is easy!"
        create_an_account
      end
    end

def create_an_account
  puts "Please enter a new username:"
  name = gets.strip
  if !Patient.find_by(name: name)
  @patient = Patient.create(name: name)
  @patient.save
  puts "Hello, #{@patient.name.split(" ")[0]}"
  puts "Please choose a password:"
  password = gets.strip
  @patient.password = password
  @patient.save
  puts "Thank you, would you like to run the program now? (y/n)"
  choices_after_account_creation
  else
    puts "That username is taken"
    puts "You must choose a unique username"
    create_an_account
  end

end

def choices_after_account_creation
  open_or_not = gets.strip.downcase
  case open_or_not
  when "y", "yes"
    menu
  when "n", "no"
    puts "Thank you for creating an account. See you soon!"
  else
    puts "Invalid response:"
    puts "please enter yes or no"
    choices_after_account_creation
  end
end

def password_authenticate
  puts "Please enter your password:"
  password = gets.strip
  if @patient.authenticate(password)
    puts "Welcome #{@patient.name.split(" ")[0]}"
   menu
  else
    puts "The password you entered is incorrect"
    puts "Please choose one:"
    puts "1: Try again"
    puts "2: Create a new account"

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
      puts "Invalid response:"
      puts "please enter 1 or 2"
      validate_password_response
  end
end
user_login_menu
