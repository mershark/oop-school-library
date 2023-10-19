require 'rspec'
require_relative '../person'
require 'date'
require_relative '../rental'
require_relative '../book'

describe Person do
  describe 'creating a new person' do
    let(:person) { Person.new(30, 'Joe', parent_permission: true) }

    it 'should have the correct attributes' do
      expect(person.id).to be_an(Integer)
      expect(person.name).to eq('Joe')
      expect(person.age).to eq(30)
      expect(person.instance_variable_get(:@parent_permission)).to be(true)
      expect(person.rentals).to eq([])
    end
  end

  describe 'checking if a person can use services' do
    describe 'when of age' do
      let(:person) { Person.new(18, 'Tom', parent_permission: true) }

      it 'should return true' do
        expect(person.can_use_services?).to be(true)
      end
    end

    describe 'when under age with parent permission' do
      let(:person) { Person.new(17, 'Sam', parent_permission: true) }

      it 'should return true' do
        expect(person.can_use_services?).to be(true)
      end
    end

    describe 'when under age without parent permission' do
      let(:person) { Person.new(15, 'Katy', parent_permission: false) }

      it 'should return false' do
        expect(person.can_use_services?).to be(false)
      end
    end
  end

  describe 'adding a new rental' do
    let(:person) { Person.new(30, 'Joe', parent_permission: true) }
    let(:book) { Book.new('Sample Book', 'Sample Author') }
    let(:date) { Date.today }

    it 'should add a new rental to rentals array' do
      person.add_new_rental(date, book)
      expect(person.rentals.size).to eq(2)
      added_rental = person.rentals.first
      expect(added_rental.date).to eq(date)
      expect(added_rental.book).to eq(book)
      expect(added_rental.person).to eq(person)
    end
  end

  describe 'correct name' do
    let(:person) { Person.new(30, 'John Doe', parent_permission: true) }

    it 'should return the correct name' do
      expect(person.correct_name).to eq('John Doe')
    end
  end
end
