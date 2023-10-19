require_relative '../decorator'

class FakeNameable
  def correct_name
    'Original Name'
  end
end

describe Decorator do
  let(:fake_nameable) { FakeNameable.new }
  let(:decorator) { Decorator.new(fake_nameable) }

  describe '#correct_name' do
    it 'returns the correct name from the decorated object' do
      expect(decorator.correct_name).to eq('Original Name')
    end
  end
end
