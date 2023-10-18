module BookCreationManager
  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp

    new_book = Book.new(title, author)
    @books << new_book
    puts 'Book Created Successfully'
    save_books('books.json', @books)
  end
end
