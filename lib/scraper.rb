require_relative "./environment"

class MissingPersons::Scraper

    
    def self.get_inital_info
   
    site = "https://www.fbi.gov/wanted/kidnap/"
    doc = Nokogiri::HTML(open(site))
    
    per_page  = doc.css(".read-more.text-center.bottom-total.visualClear").text.split[2].to_f # 40.0
    total_amount = doc.css(".read-more.text-center.bottom-total.visualClear").text.split[4].to_f # 93.0
    last_page = (total_amount.to_f/per_page.to_f).ceil # 2.325 round to 3
    page = 1
    
    p_array = []
        
    # pagination loop to final page
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
        page += 1
        end
        MissingPersons::Person.mass_create_from_scraper(p_array) # creates person object from/using person class
    end
    
    def self.get_more_info(person_object)
        url = person_object.url
        doc = Nokogiri::HTML(open(url))
        info = doc.css(".table.table-striped.wanted-person-description tbody").text
        puts info 
    end
end



