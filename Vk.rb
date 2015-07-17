class Vk

  def set_data_country 

    data = HTTParty.get ("https://api.vk.com/method/database.getCountries?need_all=1")
    return data

  end

  def set_data_city(id)

    data = HTTParty.get ("https://api.vk.com/method/database.getCities?country_id=" + id.to_s)
    return data

  end

  def set_data_universitet(id)

    data = HTTParty.get ("https://api.vk.com/method/database.getUniversities?city_id=" + id.to_s)
    return data

  end

  def parse_json(str)

    return result = JSON.parse(str.response.body)

  end




end
