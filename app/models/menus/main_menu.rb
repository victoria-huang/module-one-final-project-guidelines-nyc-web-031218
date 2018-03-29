require_relative '../../../config/environment'

def main_menu
  puts "\nWhere would you like to go?\n\n"
  puts "Main Menu Options:"
  puts "1. Prescriptions Menu"
  puts "2. Doctors Menu"
  puts "3. Reminders Menu"
  puts "4. Profile Menu"
  puts "5. Exit Program\n\n"

  response = gets.strip
end
