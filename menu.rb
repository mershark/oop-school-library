class Menu
    MENU = "Please choose an option by entering a number:
    1 - List all books
    2 - List all people
    3 - Create a person
    4 - Create a book
    5 - Create a rental
    6 - List all rentals for a given person ID
    7 - Exit".freeze
  
    def self.display
      puts MENU
    end
  end