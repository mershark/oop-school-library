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

  def self.display_library_menu
    puts 'Library Management System'
    puts '1. List Books'
    puts '2. List People'
    puts '3. Create Person'
    puts '4. Create Book'
    puts '5. Create Rental'
    puts '6. List Rentals by Person ID'
    puts '7. Exit'
  end
end
