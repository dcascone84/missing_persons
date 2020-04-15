require_relative "./missing_persons/version"

require "open-uri"
require "nokogiri"
require "pry"

require_relative "./cli"
require_relative "./Scraper"
require_relative "./person"

module MissingPersons
  class Error < StandardError; end
  # Your code goes here...
end
