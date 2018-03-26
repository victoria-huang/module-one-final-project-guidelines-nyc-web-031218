ENV["SINATRA_ENV"] ||= "development"
require "sinatra/activerecord/rake"
require_relative './config/environment'
# desc 'outputs hello to the terminal'
# task :hello do
#   puts "hello from Rake!"
# end
#
task :environment do
  require_relative './config/environment'
end
#
# namespace :db do
#   desc 'migrate changes to your database'
#   task :migrate => :environment do
#     Student.create_table
#   end
# end
desc 'drop into the Pry console'
task :console => :environment do
  Pry.start
end
