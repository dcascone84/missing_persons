require_relative "./environment"

class MissingPersons::Scraper

    
    def self.get_inital_info
    site = "https://www.fbi.gov/wanted/kidnap/"
    doc = Nokogiri::HTML(open(site))
    names = doc.css("ul.full-grid.wanted-grid-natural.infinity.castle-grid-block-xs-2.castle-grid-block-sm-2castle-grid-block-md-3.castle-grid-block-lg-5.dt-grid li")
    
    page = 1
    per_page = names.count #40
    total = doc.css(".right").text.split(" ")[1].to_i #91
    last_page = (total.to_f/per_page.to_f).round
    
    
    p_array = []
    while page <= last_page
        pagination_url = "https://www.fbi.gov/wanted/kidnap/@@castle.cms.querylisting/querylisting-1?page=#{page}"
        pagination_doc = Nokogiri::HTML(open(pagination_url))
        pagination_names = pagination_doc.css("ul.full-grid.wanted-grid-natural.infinity.castle-grid-block-xs-2.castle-grid-block-sm-2castle-grid-block-md-3.castle-grid-block-lg-5.dt-grid li")
        pagination_names.each do |name|
            p_hash = {
                name: name.css("h3").text.strip,
                url: name.css("a").attr("href").value
            }
            p_array << p_hash
            end
        MissingPersons::Person.mass_create_from_scraper(p_array)
        page += 1
        end
    end


    def self.get_more_info(person_object)
        url = person_object.url
        doc = Nokogiri::HTML(open(url))
        info = doc.css(".table.table-striped.wanted-person-description tbody").text
        puts info 
    end
end


MissingPersons::Scraper
