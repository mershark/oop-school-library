require_relative '../book'
require 'rspec'

describe Book do
    let(:book) { Book.new('Ring Shout', 'FP. P. Djèlí Clark') }
  
    describe 'creating a new book' do
      it 'should have the correct properties' do
        expect(book.title).to eq('Ring Shout')
        expect(book.author).to eq('FP. P. Djèlí Clark')
        expect(book.rentals).to be_an(Array)
        expect(book.rentals).to be_empty
      end
    end
  
    describe 'converting a book to a hash' do
      it 'should have the correct hash structure' do
        hash = book.to_hash
  
        expect(hash['title']).to eq('Ring Shout')
        expect(hash['author']).to eq('FP. P. Djèlí Clark')
      end
    end
  end
