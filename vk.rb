require 'httparty'
require 'json'
require "fileutils"
require_relative 'CatalogCountryCityUniversitiesFromVk.rb'

object = CatalogCountryCityUniversitiesFromVk.new                  #создали объект класса CatalogContryCityUniversitiesFromVk

data_country_all = object.parse_json(object.set_data_country_all) #получили данные от метода set_data_country_all и сразу распарсили их
data_country = object.parse_json(object.set_data_country)

object.creat_catalog(data_country_all)                            #запустили метод создания каталога и передали в него хешь всех стран
object.creat_catalog(data_country)                                #полученных от vkappi
