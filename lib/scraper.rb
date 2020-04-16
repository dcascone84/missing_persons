require_relative "./environment"

class MissingPersons::Scraper

    
    def self.get_inital_info
    
    site = "https://www.fbi.gov/wanted/kidnap/@@castle.cms.querylisting/querylisting-1?page=1"
    doc = Nokogiri::HTML(open(site))
    names = doc.css("ul.full-grid.wanted-grid-natural.infinity.castle-grid-block-xs-2.castle-grid-block-sm-2castle-grid-block-md-3.castle-grid-block-lg-5.dt-grid li")
    
    p_array = []

        names.each do |name|
        p_hash = {

            name: name.css("h3").text.strip,
            url: name.css("a").attr("href").value
        }

        p_array << p_hash
        end
        MissingPersons::Person.mass_create_from_scraper(p_array)
    end

end

