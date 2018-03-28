# require 'pry'
# require 'sinatra/activerecord'
# require 'json'
# require 'nokogiri'
require 'bundler'
Bundler.require

def check_string(string)
  string.scan(/\D/).empty?
end

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/development.db"
)

require_all 'lib'
Dir[File.join(File.dirname(__FILE__), "../app/models/classes", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../app/models/menus", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../app/models/option_methods", "*.rb")].each {|f| require f}
# require_relative '../app/models/prescription'
# require_relative '../app/models/interaction'
# require_relative '../app/models/seeds'
