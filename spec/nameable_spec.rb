require_relative '../nameable'

module Test
  class FakeNameable < Nameable
  end

  describe Nameable do
    let(:fake_nameable) { FakeNameable.new }

    describe '#correct_name' do
      it 'raises NotImplementedError' do
        expect { fake_nameable.correct_name }.to raise_error(NotImplementedError)
      end
    end
  end
end
