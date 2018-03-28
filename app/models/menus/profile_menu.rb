require_relative '../../../config/environment'

def profile_menu
  puts "\nWhat would you like to do?\n\n"
  puts "Profile Options:"
  puts "1. Change your username"
  puts "2. Change your password"
  puts "3. Return to main menu\n\n"

  response = gets.strip
end
