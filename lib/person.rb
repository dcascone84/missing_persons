

class MissingPersons::Person
    
    @@all = []

    def self.all
        @@all
    end

    def self.mass_create_from_scraper(person_arr)
        person_arr.each do |person_hash|
            new(person_hash[:name], person_hash[:url])
        end
    end

    attr_accessor :name, :url

    def initialize(name, url)
        @name = name
        @url = url
        save
    end

    def save
        @@all << self
    end
end