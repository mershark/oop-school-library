require_relative 'app'
require_relative 'menu'

puts "\nWelcome to School Library App!\n\n"

def main
  app = LibraryApp.new
  get = 0
  until get == 7
    Menu.display
    get = gets.chomp.to_i
    app.handle_choice(get)
  end
  puts 'Thank you for using this app!'
end

main
