<<<<<<< HEAD
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
=======
def menu
puts "What would you like to do?"
puts "choices:"
puts "1. add a prescription"
puts "2. check if existing prescriptions have any interactions"
puts "3. get a list of all your existing prescriptions"
puts "4. get a list of all your doctors' names"
puts "5. create a reminder"
puts "6. see all your reminders"

response = gets.strip
>>>>>>> option_methods
end
