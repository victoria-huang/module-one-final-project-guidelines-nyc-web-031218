require_relative '../config/environment'

def menu
  puts "\nWhat would you like to do?\n\n"
  puts "Choices:"
  puts "1. Add a prescription"
  puts "2. Check if existing prescriptions have any drug interactions"
  puts "3. Get a list of all your existing prescriptions"
  puts "4. Get a list of all your doctors' names"
  puts "5. Create a reminder"
  puts "6. See all your reminders"
  puts "7. Exit program\n\n"

  response = gets.strip
end
