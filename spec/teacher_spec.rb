require_relative '../teacher'
require 'rspec'

describe Teacher do
  let(:teacher) { Teacher.new(30, 'Math', 'John Doe') }

  it 'is an instance of Teacher' do
    expect(teacher).to be_an_instance_of(Teacher)
  end

  it 'inherits from Person' do
    expect(teacher).to be_a(Person)
  end

  it 'has a specialization' do
    expect(teacher.instance_variable_get(:@specialization)).to eq('Math')
  end

  it 'can use services' do
    expect(teacher.can_use_services?).to be(true)
  end

  it 'can be converted to a hash' do
    expected_hash = {
      'id' => teacher.id,
      'age' => 30,
      'name' => 'John Doe',
      'parent_permission' => true,
      'specialization' => 'Math'
    }
    expect(teacher.to_hash).to eq(expected_hash)
  end
end
