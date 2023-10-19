require_relative '../person'
require_relative '../person'
require_relative '../capitalize_decorator'
require 'rspec'

describe CapitalizeDecorator do
  it 'should capitalize the first letter' do
    person = Person.new(22, 'ricardo')
    capitalize_person = CapitalizeDecorator.new(person)
    expect(capitalize_person.correct_name).to eq 'Ricardo'
  end
end