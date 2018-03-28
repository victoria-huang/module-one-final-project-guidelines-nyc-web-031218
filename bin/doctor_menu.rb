require_relative '../config/environment'

def doctor_menu
  puts "\nWhat would you like to do?\n\n"
  puts "Choices:"
  puts "1. Get a list of all your doctors' names"
  puts "2. Return to main menu"
  puts "3. Exit program\n\n"

  response = gets.strip
end
