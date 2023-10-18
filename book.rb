class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_new_rental(date, person)
    rental = Rental.new(date, self, person)
    @rentals << rental
  end

  def to_hash
    {
      'title' => @title,
      'author' => @author
    }
  end
end
