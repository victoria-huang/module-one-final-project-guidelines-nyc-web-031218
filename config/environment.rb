# require 'pry'
# require 'sinatra/activerecord'
# require 'json'
# require 'nokogiri'
require 'bundler'
Bundler.require


connection = ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/development.db"
)
Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
# require_relative '../app/models/prescription'
# require_relative '../app/models/interaction'
# require_relative '../app/models/seeds'
