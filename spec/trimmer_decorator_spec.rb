require_relative '../trimmer_decorator'
require 'rspec'

describe TrimmerDecorator do
  it 'is an instance of TrimmerDecorator' do
    decorator = TrimmerDecorator.new('This is a long string')
    expect(decorator).to be_an_instance_of(TrimmerDecorator)
  end
end
