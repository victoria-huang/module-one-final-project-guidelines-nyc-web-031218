require_relative '../config/environment'

def main_menu
  puts "\nWhere would you like to go?\n\n"
  puts "Choices:"
  puts "1. Prescriptions"
  puts "2. Doctors"
  puts "3. Reminders"
  puts "4. Profile"
  puts "5. Exit program\n\n"

  response = gets.strip
end
