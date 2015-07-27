class Database

  attr_accessor :db,:countries,:city,:universitet

  def initialize
    @db = Sequel.sqlite
    creat_table_countries
    creat_table_city
    creat_table_universitet
    @countries = @db[:tbl_countries]
    @city = @db[:tbl_city]
    @universitet = @db[:tbl_universitet]
  end

  def creat_table_countries
    @db.create_table :tbl_countries do
      primary_key :id
      String :name
    end
  end

  def creat_table_city
    @db.create_table :tbl_city do
      primary_key :id
      String :name
      Integer :countries_id
    end
  end

  def creat_table_universitet
    @db.create_table :tbl_universitet do
      primary_key :id
      String :name
      integer :countries_id
      integer :city_id
    end
  end

  def pushCountriesFromDB
    Dir.foreach('countries') do |country|
      if country.to_s != ".." && country.to_s != "."
        @countries.insert(:name => country.to_s)
      end
    end
  end

  def pushCityFromDB
    @db['select * from tbl_countries'].each do |row|
        nameDir = 'countries/' + row[:name].to_s
        Dir.foreach(nameDir.to_s) do |city|
          if city.to_s != ".." && city.to_s != "."
            city.sub!('.txt', "")
            @city.insert(:name => city.to_s, :countries_id => row[:id])
          end
        end
    end
  end

  def pushUniversitetFromDB
    Dir.foreach('countries') do |country|
      if country.to_s != ".." && country.to_s != "."
        Dir.foreach('countries/' + country.to_s) do |city|
          if city.to_s != ".." && city.to_s != "."
            f = File.new("countries/" + country.to_s + '/' + city.to_s)
            city.sub!('.txt', "")
            country_id = setIdCountries(country.to_s)
            city_id = setIdCity(city.to_s)
            f.each do |line|
              @universitet.insert(:name => line.to_s, :countries_id => country_id, :city_id => city_id)
            end
          end
        end
      end
    end
  end

  def setIdCountries country_name
      country = db[:tbl_countries]
      data = country[:name => country_name.to_s]
      return data[:id]
  end

  def setIdCity city_name
      city = db[:tbl_city]
      data = city[:name => city_name.to_s]
      return data[:id]
  end

  def getUniversitetCity id
    data = @db['select * from tbl_universitet where city_id = ?', id]
    return data
  end

  def getUniversitetCountry id
    data = @db['select * from tbl_universitet where countries_id = ?', id]
    return data
  end

end
