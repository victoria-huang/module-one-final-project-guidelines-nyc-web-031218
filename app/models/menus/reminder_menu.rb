require_relative '../../../config/environment'

def reminder_menu
  puts "\nWhat would you like to do?\n\n"
  puts "Reminder Options:"
  puts "1. Create a reminder"
  puts "2. See all your reminders"
  puts "3. Edit a reminder"
  puts "4. Remove a reminder"
  puts "5. Clear all reminders"
  puts "6. Return to main menu\n\n"
  response = gets.strip
end
