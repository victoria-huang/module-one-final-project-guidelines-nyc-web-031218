require_relative '../../../config/environment'
require_relative 'main_menu_methods'
require_relative '../menus/reminder_menu'

def reminder_methods
  case reminder_menu
  when "1"
    puts "\nPlease enter your reminder:\n\n"
    note = gets.strip
    # # VICKY: remember to add menu/control options later!!!
    # if note == 'Q' || note =='q'
    #   options_methods
    # else
    @patient.add_reminder(note)
    puts "\nThank you for adding a reminder!\n\n"
    # end
    sleep(1)
    reminder_methods
  when "2"
    list_reminders
    reminder_methods
  when "4"
    list_reminders
    
  when "5"
    puts "\nAre you sure you want to delete all you reminders? (y/n)"
    del_response
  when "6"
    main_menu_methods
  else
    puts "\nSorry, that is an invalid response."
    puts "Please enter a number from 1-3\n"
    sleep(1)
    reminder_methods
  end
end

def list_reminders
  @patient.reminders.reload
  if @patient.reminders.count > 0
  puts "These are your current reminders:"
  @patient.reminders.uniq.each_with_index{|reminder, index| puts "\n#{index+1}. #{reminder.note}\n";
  sleep(1)}
  else
    puts "You currently have no reminders"
  end
end

def del_response
  response = gets.strip
  case response
   when "yes", "y"
     Reminder.delete_all
     sleep(1)
     puts "Thank you, we have finished deleting your reminders\n"
     sleep(0.5)
   when "no", "n"
     puts "ok"
     sleep(1)
   else
     puts "That is not a valid response, please enter yes or no"
     del_response
   end
    reminder_methods
 end
