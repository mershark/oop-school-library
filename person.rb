require_relative 'nameable'

class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age, :rentals

  @id_counter = 0

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    self.class.id_counter ||= 0 # Initialize id_counter if it's nil.
    self.class.id_counter += 1 # Increment the ID counter using the class instance variable.
    @id = self.class.id_counter
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

  class << self
    attr_accessor :id_counter
  end

  private

  def of_age?
    @age >= 18
  end
end
