require_relative 'book'

module BookManager
  def create_book(title, author)
    new_book = Book.new(title, author)
    @books << new_book
    puts 'Book Created Successfully'
    save_books('books.json', @books) # Save book data after creating a book
  end

  def list_books
    puts 'List of Books:'
    @books.each do |book|
      puts "Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  def find_book_by_title(title)
    @books.find { |book| book.title == title }
  end
end
