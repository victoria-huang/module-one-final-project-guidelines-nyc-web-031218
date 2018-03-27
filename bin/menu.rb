require_relative '../config/environment'

def menu
  puts "What would you like to do?"
  puts "Choices:"
  puts "1. Add a prescription"
  puts "2. Check if existing prescriptions have any drug interactions"
  puts "3. Get a list of all your existing prescriptions"
  puts "4. Get a list of all your doctors' names"
  puts "5. Create a reminder"

  response = gets.strip
end
