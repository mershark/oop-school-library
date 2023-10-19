require_relative '../student'
require_relative '../classroom'
require 'rspec'

describe Student do
  let(:classroom) { Classroom.new('16B') }
  let(:student) { Student.new(16, classroom, 'Ben', parent_permission: true) }

  describe 'creating a new student' do
    it 'should have the correct attributes' do
      expect(student.name).to eq('Ben')
      expect(student.age).to eq(16)
      expect(student.parent_permission).to eq(true)
      expect(student.classroom).to eq(classroom)
    end
  end

  describe 'updating classroom' do
    it 'should update the classroom and add the student to the classroom' do
      new_classroom = Classroom.new('5A')
      student.classroom = new_classroom

      expect(student.classroom).to eq(new_classroom)
      expect(new_classroom.students).to include(student)
    end
  end

  describe 'playing hooky' do
    it 'should return the hooky message' do
      expect(student.play_hooky).to eq('¯\(ツ)/¯')
    end
  end

  describe 'converting a student to a hash' do
    it 'should have the correct hash structure' do
      hash = student.to_hash

      expect(hash['id']).to eq(student.id)
      expect(hash['name']).to eq('Ben')
      expect(hash['age']).to eq(16)
      expect(hash['parent_permission']).to eq(true)
      expect(hash['classroom']).to eq(classroom)
    end
  end
end
