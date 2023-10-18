require_relative 'rental'

module RentalManager
  def create_rental
    date = rental_date
    book_number, person_number = book_and_person_selection

    if book_number && person_number
      create_rental_with_indexes(date, book_number - 1, person_number - 1)
      puts 'Rental Created Successfully'
    else
      puts 'Invalid book or person selection. Rental creation failed.'
    end
  end

  private

  def rental_date
    print 'Date (YYYY/MM/DD): '
    gets.chomp
  end

  def book_and_person_selection
    book_number = select_book
    person_number = select_person

    [book_number, person_number]
  end

  def select_book
    puts 'Available Books:'
    display_books

    print 'Select a book (enter the number not ID): '
    gets.chomp.to_i
  end

  def select_person
    puts 'Available People:'
    display_people

    print 'Select a person (enter the number not ID): '
    gets.chomp.to_i
  end

  def display_books
    @books.each_with_index do |book, index|
      puts "#{index + 1} - Title: #{book.title}, Author: #{book.author}"
    end
  end

  def display_people
    @people.each_with_index do |person, index|
      person_type = person.is_a?(Student) ? 'Student' : 'Teacher'
      puts "#{index + 1} - #{person_type} Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end
end
