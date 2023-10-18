require_relative 'student'
require_relative 'teacher'
require 'json'

module DataManager
  module_function

  def save_books(filename, books)
    books_data = books.map do |book|
      {
        'title' => book.title,
        'author' => book.author
      }
    end

    data_to_save = {
      books: books_data
    }
    save_to_json(filename, data_to_save)
  end

  def load_books(filename)
    loaded_data = load_from_json(filename, 'books')
    @books = loaded_data.map do |book_data|
      Book.new(book_data['title'], book_data['author'])
    end
  end

  def save_rentals(filename, rentals)
    data_to_save = {
      rentals: rentals.map(&:to_hash)
    }
    save_to_json(filename, data_to_save)
  end

  def load_rentals(filename)
    loaded_data = load_from_json(filename, 'rentals')
    @rentals = loaded_data.map do |rental_data|
      book = find_book_by_title(rental_data['book']['title'])
      person = find_person_by_id(rental_data['person']['id'])
      Rental.new(rental_data['date'], book, person) if book && person
    end.compact
  end

  def save_people(filename, people)
    data_to_save = {
      people: people.map(&:to_hash)
    }
    save_to_json(filename, data_to_save)
  end

  def load_people(filename)
    loaded_data = load_from_json(filename, 'people')
    @people = loaded_data.map do |person_data|
      if person_data['classroom']
        Student.new(person_data['age'], person_data['classroom'], person_data['name'],
                    parent_permission: person_data['parent_permission'])
      else
        Teacher.new(person_data['age'], person_data['specialization'], person_data['name'],
                    parent_permission: person_data['parent_permission'])
      end
    end
  end


  private

  def save_to_json(filename, data)
    File.open(filename, 'w') do |file|
      json_data = JSON.dump(data)
      file.write(json_data)
    end
  end

  def load_from_json(filename, key)
    if File.exist?(filename)
      json_data = File.read(filename)
      data = JSON.parse(json_data)
      data[key] || []
    else
      []
    end
  end
end
