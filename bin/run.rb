`bundle install`
require_relative '../config/environment'
require_relative '../app/models/menus/user_login_menu'

puts "Welcome to the Prescription Organizer App!\n"
sleep(1.5)
puts "\nThis app is built for you to organize"
puts "your medical prescriptions and check if your\n"
puts "prescriptions interact in harmful ways.\n"
puts "You can do things like add a prescription,\n"
puts "add a reminder, or ask if your prescriptions \n"
puts "have any interactions."
puts "\nWe hope you enjoy using our app!\n"
continue_on
user_login_menu
# puts "In the Prescriptions Menu, you can"
# sleep(1.5)
# puts "a) add new prescriptions, b) view existing prescriptions"
# sleep(1.5)
# puts "c) check if existing prescriptions interact harmfully,"
# sleep(1.5)
# puts "d) remove a prescription, e) edit an existing prescription.\n"
# continue_on
# puts "In the Doctors Menu, you can view a list of all your
# doctors\n"
# continue_on
# puts "In the Reminders Menu, you can a) add a new reminder,"
# sleep(1.5)
# puts "b) view your existing reminders, c) remove a reminder,"
# sleep(1.5)
# puts "c) clear all your reminders"
# continue_on
# puts "In the Profile Menu, you can change your username
# and password.\n\n"
# sleep(1.5)

# continue?
