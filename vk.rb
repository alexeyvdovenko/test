require 'httparty'
require 'json'
require "fileutils"
require_relative 'Vk.rb'

object = Vk.new
result = object.parse_json(object.set_data_country)

# dir = Dir.open('test')
#   object.creat_file('text.txt')
# dir.close


result.each{|k,all_contry|
  all_contry.each{|contry|
    contry.each{|key,value|
      if(key.to_s == 'title')
          object.creat_dir(value.to_s)
      end

    }
  }
}
