require_relative 'app'

puts "\nWelcome to School Library App!\n\n"

MENU = "Please choose an option by entering a number:
1 - List all books
2 - List all people
3 - Create a person
4 - Create a book
5 - Create a rental
6 - List all rentals for a given person ID
7 - Exit".freeze

def switch(get, app)
  case get
  when 1
    app.list_books
  when 2
    app.list_people
  when 3
    app.create_person
  when 4
    app.create_book
  when 5
    app.create_rental
  when 6
    app.list_rentals
  end
end

def main
  app = LibraryApp.new
  get = 0
  while get != 7 and get < 7
    puts MENU
    get = gets.chomp.to_i
    switch(get, app)
  end
  puts 'Thank you for using this app!'
end

main
