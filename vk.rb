require 'httparty'
require 'json'

a = HTTParty.get ("https://api.vk.com/method/database.getCountries?need_all=1")


result = JSON.parse(a.response.body)

result.each{|arr|
  puts arr
}
