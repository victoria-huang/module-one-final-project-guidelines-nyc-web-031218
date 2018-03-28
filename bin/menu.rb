require_relative '../config/environment'

def menu
  puts "What would you like to do?\n\n"
  puts "Choices:"
  puts "1. Add a prescription"
<<<<<<< HEAD
  puts "2. Remove a prescription"
  puts "3. Check if existing prescriptions have any interactions"
  puts "4. Get a list of all your existing prescriptions"
  puts "5. Get a list of all your doctors' names"
  puts "6. Create a reminder"
  puts "7. See all your reminders"
  puts "8. Exit program"
=======
  puts "2. Check if existing prescriptions have any drug interactions"
  puts "3. Get a list of all your existing prescriptions"
  puts "4. Get a list of all your doctors' names"
  puts "5. Create a reminder"
  puts "6. See all your reminders"
  puts "7. Exit program"
>>>>>>> 5f6f1e7fb12d15456dce6fbc2d1c209d6513386f

  response = gets.strip
end
