require "rubygems"
require 'sequel'
require_relative "Database.rb"

test = Database.new
test.pushCountriesFromDB
test.pushCityFromDB
test.pushUniversitetFromDB

a = ARGV

if a[0] == '-city'
  name = a[1].to_s
  id = test.setIdCity name
  data = test.getUniversitetCity id
  data.each do |universitet|
    puts universitet[:name]
  end
elsif a[0] == '-country'
  name = a[1].to_s
  id = test.setIdCountries name
  data = test.getUniversitetCountry id
  data.each do |universitet|
    puts universitet[:name]
  end
else
  puts "Не верные данные"
end

