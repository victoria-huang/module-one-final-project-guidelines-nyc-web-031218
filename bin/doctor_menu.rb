require_relative '../config/environment'

def doctor_menu
  puts "\nWhat would you like to do?\n\n"
  puts "Doctor Options:"
  puts "1. Get a list of all your doctors' names"
  puts "2. Return to main menu\n\n"

  response = gets.strip
end
