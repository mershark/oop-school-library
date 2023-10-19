require_relative '../rental'
require 'rspec'

describe Rental do
  let(:book) { double('Book', rentals: []) }
  let(:person) { double('Person', rentals: []) }

  let(:date) { '2023-10-19' }
  let(:rental) { Rental.new(date, book, person) }

  it 'is an instance of Rental' do
    expect(rental).to be_an_instance_of(Rental)
  end

  it 'has a date' do
    expect(rental.date).to eq('2023-10-19')
  end

  it 'is associated with a book' do
    expect(rental.book).to eq(book)
  end

  it 'is associated with a person' do
    expect(rental.person).to eq(person)
  end
end
