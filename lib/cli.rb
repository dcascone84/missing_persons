require_relative "./environment"

class MissingPersons::Cli
    
    def start
        welcome
        get_persons_info
        loop_choice
    end

    def welcome # display welcome message to user
        puts "\n\n\n"
        puts "Welcome to Missing Persons. A selection will appear momentarily."
        puts "\n\n\n"
        sleep(2)
    end

    def get_persons_info # populates Person.all using Scraper method
        MissingPersons::Scraper.get_inital_info
    end

    def loop_choice #loops valid / invalid choices / invokes #menu, get_person, display_person(input) / breaks loop (exit)
        loop do
            menu
            input = get_user_input
            break if input == "exit"
            next if input == "invalid"
            display_person(input)
        end
    end

    def get_user_input #gets user input and with it app decide how to respond
        input = gets.downcase.strip
        return input if input == "exit"
        if !valid?(input)
            puts "Not a valid choice. Please choose again." 
            return "invalid" 
        end    
        return input.to_i - 1
    end

    def menu
        display_names
        display_instructions
    end

    def display_names
        MissingPersons::Person.all.each.with_index do |person, index|
            puts "#{index+1}. #{person}"
        end
    end

    def display_instructions
        puts "\n"
        puts "Please choose a number to view more information about a person. Type 'exit' to exit program."
        puts "\n"
    end

    def display_person(input) # displays user input (person )
        person = MissingPersons::Person.all[input]
        puts "\n\n\n\n\n\n"
        puts person.name
        puts person.url
        MissingPersons::Scraper.get_more_info(person) if !person.full?
        puts "\n" 
        puts "To continue press 'enter'."
        gets
    end

    def valid?(input)
        input.to_i.between?(1, MissingPersons::Person.all.length)
    end

end

MissingPersons::Cli