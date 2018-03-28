require_relative '../config/environment'

def reminder_menu
  puts "\nWhat would you like to do?\n\n"
  puts "Choices:"
  puts "1. Create a reminder"
  puts "2. See all your reminders"
  puts "3. Return to main menu"
  puts "4. Exit program\n\n"

  response = gets.strip
end
