# require 'pry'
# require 'sinatra/activerecord'
# require 'json'
# require 'nokogiri'
require 'bundler'
Bundler.require

def check_string_integer(string)
  string.scan(/\D/).empty?
end

def check_include_integer(string)
  string.scan(/\d/).length > 0
end
def check_string_case(string)
  string != string.downcase && string != string.upcase
end

def check_string_special(string)
special = "!@?<>',?[]}{=-)(*&^%$#`~{}"
regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/
string =~ regex
end

def check_string_empty(string)
string != ""
end

def continue?
  puts "(press enter to continue)"
  gets
end

def continue_on
  puts "(press enter to continue)"
  gets
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
