def user_login_menu
  puts "Do you already have an account? (y/n)"
  answer = gets.strip.downcase
  login(answer)
end

def login(answer)
    case answer
      when "y" || "yes"
        puts "Great!"
        puts "Please enter your full name:"
        name = gets.strip
        if Patient.find_by(name: name)
          @patient = Patient.find_by(name: name)
          password_authenticate
        else
          puts "The account you entered doesn't exist."
          puts "Please choose one:"
          puts "1: Try again"
          puts "2: Create a new account"
          choice = gets.strip
          case choice
            when "1"
              login(answer)
            when "2"
              create_an_account
          end
        end
      when "n" || "no"
        puts "Ok, creating a new account is easy!"
        create_an_account
      end
    end

def create_an_account
  puts "Please enter your full name:"
  name = gets.strip
  @patient = Patient.create(name: name)
  @patient.save
  puts "Hello, #{@patient.name.split(" ")[0]}"
  puts "Please choose a password:"
  password = gets.strip
  @patient.password = password
  @patient.save
  "Thank you, would you like to run the program now? (y/n)"
  open_or_not = gets.strip.downcase
  case open_or_not
    when "y" || "yes"
    main_menu_methods
  when "n" || "no"
    puts "Goodbye"
  end
end

def password_authenticate
  puts "Please enter your password:"
  password = gets.strip
  if @patient.authenticate(password)
    puts "Welcome #{@patient.name.split(" ")[0]}"
    main_menu_methods 
  else
    puts "The password you entered is incorrect"
    puts "Please choose one:"
    puts "1: Try again"
    puts "2: Create a new account"
    choice = gets.strip
    case choice
      when "1"
        password_authenticate
      when "2"
        create_an_account
    end
  end
end
