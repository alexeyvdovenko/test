class CatalogCountryCityUniversitiesFromVk

  def set_data_country_all
    data = HTTParty.get ("https://api.vk.com/method/database.getCountries?need_all=1")
    return data                                                       #получили данные странн от вкаппи
  end

  def set_data_country
    data = HTTParty.get ("https://api.vk.com/method/database.getCountries?need_all=0")
    return data                                                       #получили данные странн которые не вошли в предыдущий метод от вкаппи
  end

  def set_data_city(id)
    data = HTTParty.get ("https://api.vk.com/method/database.getCities?country_id=" + id.to_s)
    return data                                                       #получили данные городов для заданного id от вкаппи
  end

  def set_data_universitet(id)
    data = HTTParty.get ("https://api.vk.com/method/database.getUniversities?city_id=" + id.to_s)
    return data                                                       #получили данные высших учебный заведений для заданного id-города от вкаппи
  end

  def parse_json(str)
    return result = JSON.parse(str.response.body)                     #распарсили данные
  end

  def creat_dir (name)                                                #создаем директорию с указанным именем
    dir = "countries/"+ name.to_s
    FileUtils::mkdir_p dir
  end

  def creat_file (name,way)                                           #создаем файл с указанным именем и по указанному пути
      all_way = way.to_s + name.to_s + ".txt"
      File.open all_way,'w+'
  end

  def push_text_file(name,str)                                        #записали указанные данные в указанный файл
    file = File.open(name.to_s, 'a+')
    file.puts(str.to_s)
    file.close
  end

  def creat_catalog(data)                                             #для создания каталога передаем массив
    data.each{|k,all_countries|                                       #ичим хашь
      all_countries.each{|countries|                                  #ичим подмассив
        if countries.class == Hash                                    #если элемент массива хешь то выполняем следующее
            id_countries = countries['cid']                           #запоминаем id элемента
            title_countries = countries['title']                      #запоминаем title элемента
            data_city = parse_json(set_data_city(id_countries))       #получаем распарсенный массив для всех городов текущей страны
            creat_dir(title_countries.to_s)                           #создаем директорию для данной страны с ее названием
            creat_city_file(data_city,title_countries)                #вызываем метод создания файлов городов для данной странны
        end
      }
    }
  end

  def push_universities(data,way,cityname)                            #принимаем хешь учебных заведений, путь и имя города
    data.each{|k_universitets,all_universitets|
      all_universitets.each{|universitet|                             #проходимся по массиву учебных заведений для данного города
        if(universitet.class == Hash)
          title_universitet = universitet['title'].to_s               #получаем название учебного заведения
          name_file = way.to_s + cityname.to_s + ".txt"               #получаем полный путь до файла с названием города
          push_text_file(name_file,title_universitet)                 #вызываем метод который записывает названия учебных заведений в конец файла
        end
      }
    }
  end

  def creat_city_file(data,contryname)                                #получаем массив городов и название страны
    data.each{|k_sity,all_city|                                       #проходимся по городам
      all_city.each{|city|
        if (city.class == Hash)                                       #если очередной элемент хэшь
          id_city = city['cid']
          title_city = city['title']                                  #запоминаем имя и айди в новые переменные
          data_universitet = parse_json(set_data_universitet(id_city))#получаем распарсенные данные учебных заведений для текущего города
          way = "countries/"+ contryname.to_s + "/"                   #запомнили полный путь к файлу
          creat_file(title_city.to_s,way)                             #создали файл по указанному пути с указанным названием
          push_universities(data_universitet,way,title_city)          #вызвали метод записи учебных заведений для данного города
        end                                                           #и передали в него массив учебных заведенийБ полный путь к файлу и название города
      }
    }
  end
end
