
require_relative '../config/environment'
def menu
  puts "What would you like to do?"
  puts "Choices:"
  puts "1. Add a prescription"
  puts "2. Remove a prescription"
  puts "3. Check if existing prescriptions have any interactions"
  puts "4. Get a list of all your existing prescriptions"
  puts "5. Get a list of all your doctors' names"
  puts "6. Create a reminder"
  puts "7. See all your reminders"
  puts "8. Exit program"

  response = gets.strip
end
