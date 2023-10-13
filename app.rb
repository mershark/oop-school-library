require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'

class LibraryApp
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def run
    loop do
      display_menu
      choice = gets.chomp.to_i
      handle_choice(choice)
    end
  end

  def display_menu
    puts 'Library Management System'
    puts '1. List Books'
    puts '2. List People'
    puts '3. Create Person'
    puts '4. Create Book'
    puts '5. Create Rental'
    puts '6. List Rentals by Person ID'
    puts '7. Exit'
  end

  def handle_choice(choice)
    choice_actions = {
      1 => :list_books,
      2 => :list_people,
      3 => :create_person,
      4 => :create_book,
      5 => :create_rental,
      6 => :list_rentals,
      7 => :exit
    }

    action = choice_actions[choice]
    if action
      send(action) # Call the corresponding method
    else
      puts 'Invalid choice. Please select a valid option.'
    end
  end

  def list_books
    puts 'List of Books:'
    @books.each do |book|
      puts "Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  def list_people
    puts 'List of People:'
    @people.each do |person|
      puts "[#{person.class}] Name: #{person.name.capitalize}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person
    print 'Do you want to create a Student (1) or a Teacher (2)? [Input the number]: '
    option = gets.chomp
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp

    case option
    when '1'
      create_student(age, name)
    when '2'
      create_teacher(age, name)
    else
      puts 'Invalid option. Please select 1 for Student or 2 for Teacher.'
    end
  end

  def create_student(age, name)
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp.downcase
    print 'Classroom: '
    classroom = gets.chomp
    @people << Student.new(age, classroom, name, parent_permission: (permission == 'y'))
    puts 'Student Created Successfully'
  end

  def create_teacher(age, name)
    print 'Specialization: '
    specialization = gets.chomp
    @people << Teacher.new(age, specialization, name)
    puts 'Teacher Created Successfully'
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @books << Book.new(title, author)
    puts 'Book Created Successfully'
  end

  def create_rental
    puts 'Select a book from the following list by number'
    display_books
    book_index = gets.chomp.to_i

    return puts('Invalid book selection.') if book_index.negative? || book_index >= @books.length

    puts 'Select a person from the following list by number (not ID)'
    display_people
    person_index = gets.chomp.to_i

    return puts('Invalid person selection.') if person_index.negative? || person_index >= @people.length

    print 'Date (YYYY/MM/DD): '
    date = gets.chomp

    create_rental_with_indexes(date, book_index, person_index)
  end

  def list_rentals
    print 'ID of person: '
    person_id = gets.chomp.to_i
    puts 'Rentals:'
    @rentals.each do |rental|
      if rental.person.id == person_id
        puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author.capitalize}"
      end
    end
  end

  private

  def display_books
    @books.each_with_index { |book, index| puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def display_people
    @people.each_with_index do |person, index|
      person_type = person.is_a?(Student) ? 'Student' : 'Teacher'
      puts "#{index}) [#{person_type}] Name: \"#{person.name}\", ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_rental_with_indexes(date, book_index, person_index)
    @rentals << Rental.new(date, @books[book_index], @people[person_index])
    puts 'Rental Created Successfully'
  end
end

app = LibraryApp.new
app.run
