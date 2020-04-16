require_relative "./environment"

class MissingPersons::Cli
    
    def start
        welcome
        get_persons_info
        loop_choice
    end

    def welcome
        puts "Welcome to Missing Persons."
    end

    def get_persons_info
        MissingPersons::Scraper.get_inital_info
    end

    def loop_choice
        loop do
            menu
            input = get_person
            break if input == "exit"
            next if input == "invalid"
            display_person(input)
        end
    end
    def display_person(input)
        pers = MissingPersons::Person.all[input]
        puts pers
        puts pers.url
        puts "To continue press any key..."
        gets
    end
    
    def get_person
        input = gets.strip
        if input == "exit"
            return input
        elsif !valid?(input)
            puts "Not a valid choice. Please choose again."
            return "invalid"
        end
        return input.to_i - 1
    end

    def valid?(input)
        input.to_i.between?(1, MissingPersons::Person.all.length)
    end

    def display_names
        MissingPersons::Person.all.each.with_index do |person, index|
            puts "#{index+1}. #{person}"
        end
    end

    def menu
        display_names
        display_instructions
    end

    def display_instructions
        puts "Please choose a number to view more information about a person. Type 'exit' to exit program."
    end

    

end

MissingPersons::Cli