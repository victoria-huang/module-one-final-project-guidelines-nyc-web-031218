require_relative '../../../config/environment'

def main_menu
  puts "\nWhat would you like to do?\n\n"
  puts "Main Menu Options:"
  puts "1. Manage Prescriptions"
  puts "2. Manage Doctors"
  puts "3. Manage Reminders"
  puts "4. Manage Account"
  puts "5. Exit Program\n\n"

  response = gets.strip
end
