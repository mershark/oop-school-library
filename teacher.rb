require_relative 'person'

class Teacher < Person
  def initialize(name = "Unknown", age = 0, specialization)
    super(name, age, true)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
