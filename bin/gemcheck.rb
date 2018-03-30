def gemcheck
  if !(`gem list -i "^bcrypt$"`) && !(`gem list -i "^pry$"`) && !(`gem list -i "^savon$"`) && !(`gem list -i "^sinatra$"`) && !(`gem list -i "^rake$"`) && !(`gem list -i "^activerecord$"`) && !(`gem list -i "^sinatra-activerecord$"`) && !(`gem list -i "^sqlite3$"`) && !(`gem list -i "^activerecord-suppress_range_error$"`) && !(`gem list -i "^json$"`) && !(`gem list -i "^nokogiri$"`) && !(`gem list -i "^rest-client$"`) && !(`gem list -i "^require_all$"`) && !(`gem list -i "^bundler$"`) && !(`gem list -i "^highline$"`)

  puts "Please wait while we install dependencies"
  puts "...\n\n"
  `gem install bundler`
  `bundle install`
  end
end
