require_relative 'nameable'

class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age, :rentals

  @@id_counter = 0 # Add a class variable to keep track of IDs.

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @@id_counter += 1 # Increment the ID counter.
    @id = @@id_counter # Use the ID counter for the ID.
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_new_rental(date, book)
    @rentals << Rental.new(date, book, self)
  end

  private

  def of_age?
    @age >= 18
  end
end
