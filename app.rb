require_relative 'person'
require_relative 'book'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require_relative 'menu'
require 'json'

class LibraryApp
  def initialize
    @people = []
    @books = []
    @rentals = []
    load_books('books.json')
    load_people('people.json')
    load_rentals('rentals.json')
  end

  def run
    loop do
      Menu.display_library_menu
      choice = gets.chomp.to_i
      handle_choice(choice)
    end
  end

  def save_books(filename)
    data_to_save = {
      books: @books.map(&:to_hash)
    }
    File.open(filename, 'w') do |file|
      json_data = JSON.dump(data_to_save)
      file.write(json_data)
    end
  end

  def load_books(filename)
    if File.exist?(filename)
      json_data = File.read(filename)
      data = JSON.parse(json_data)
      books_data = data['books']
      @books = books_data.map do |book_data|
        Book.new(book_data['title'], book_data['author'])
      end
    else
      @books = []
    end
  end

  def save_rentals(filename)
    data_to_save = {
      rentals: @rentals.map(&:to_hash)
    }
    File.open(filename, 'w') do |file|
      json_data = JSON.dump(data_to_save)
      file.write(json_data)
    end
  end

  def load_rentals(filename)
    if File.exist?(filename)
      json_data = File.read(filename)
      data = JSON.parse(json_data)
      rentals_data = data['rentals']

      @rentals = rentals_data.map do |rental_data|
        book = find_book_by_title(rental_data['book']['title'])
        person = find_person_by_id(rental_data['person']['id'])

        Rental.new(rental_data['date'], book, person) if book && person
      end.compact
    else
      @rentals = []
    end
  end

  def save_people(filename)
    data_to_save = {
      people: @people.map(&:to_hash)
    }
    File.open(filename, 'w') do |file|
      json_data = JSON.dump(data_to_save)
      file.write(json_data)
    end
  end

  def load_people(filename)
    if File.exist?(filename)
      json_data = File.read(filename)
      data = JSON.parse(json_data)
      people_data = data['people']
      @people = people_data.map do |person_data|
        if person_data['classroom']
          Student.new(person_data['age'], person_data['classroom'], person_data['name'],
                      parent_permission: person_data['parent_permission'])
        else
          Teacher.new(person_data['age'], person_data['specialization'], person_data['name'],
                      parent_permission: person_data['parent_permission'])
        end
      end
    else
      @people = []
    end
  end

  def find_book_by_title(title)
    @books.find { |book| book.title == title }
  end

  def find_person_by_id(id)
    @people.find { |p| p.id == id }
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
      send(action)
      save_books('books.json')
      save_people('people.json')
      save_rentals('rentals.json')
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
      person_type = person.is_a?(Student) ? 'Student' : 'Teacher'
      puts "#{person_type} Name: #{person.name.capitalize}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person
    person_type = person_type_prompt
    age = age_prompt
    name = name_prompt

    case person_type
    when '1'
      create_student(age, name)
    when '2'
      create_teacher(age, name)
    else
      puts 'Invalid option. Please select 1 for Student or 2 for Teacher.'
    end
  end

  def person_type_prompt
    print 'Do you want to create a Student (1) or a Teacher (2)? [Input the number]: '
    gets.chomp
  end

  def age_prompt
    print 'Age: '
    gets.chomp
  end

  def name_prompt
    print 'Name: '
    gets.chomp
  end

  def create_student(age, name)
    permission = parent_permission_prompt
    classroom = classroom_prompt
    parent_permission = permission == 'y'
    @people << Student.new(age, classroom, name, parent_permission: parent_permission)
    puts 'Student Created Successfully'
    save_people('people.json') # Save people data after creating a student
  end

  def parent_permission_prompt
    print 'Has parent permission? [Y/N]: '
    gets.chomp.downcase
  end

  def classroom_prompt
    print 'Classroom: '
    gets.chomp
  end

  def create_teacher(age, name)
    print 'Specialization: '
    specialization = gets.chomp
    @people << Teacher.new(age, specialization, name)
    puts 'Teacher Created Successfully'
    save_people('people.json') # Save people data after creating a teacher
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    new_book = Book.new(title, author)
    @books << new_book
    save_books('books.json') # Save book data after creating a book
    puts 'Book Created Successfully'
  end

  def create_rental
    book_index = select_book
    return unless book_index

    person_index = select_person
    return unless person_index

    date = input_date

    create_rental_with_indexes(date, book_index, person_index)
  end

  def select_book
    puts 'Select a book from the following list by number'
    display_books
    book_index = gets.chomp.to_i
    return nil if book_index.negative? || book_index >= @books.length

    book_index
  end

  def select_person
    puts 'Select a person from the following list by number (not ID)'
    display_people
    person_index = gets.chomp.to_i
    return nil if person_index.negative? || person_index >= @people.length

    person_index
  end

  def input_date
    print 'Date (YYYY/MM/DD): '
    gets.chomp
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
    save_rentals('rentals.json') # Save rental data after creating a rental
  end
end
