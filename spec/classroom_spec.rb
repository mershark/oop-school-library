require_relative '../classroom'
require 'rspec'

module Test
  class Student
    attr_accessor :classroom
  end

  describe Classroom do
    let(:classroom) { Classroom.new('Math Class') }

    it 'is an instance of Classroom' do
      expect(classroom).to be_an_instance_of(Classroom)
    end

    it 'has a label' do
      expect(classroom.label).to eq('Math Class')
    end

    it 'initially has no students' do
      expect(classroom.students).to be_empty
    end

    it 'can add students' do
      student = Student.new
      classroom.add_student(student)
      expect(classroom.students).to include(student)
      expect(student.classroom).to eq(classroom)
    end
  end
end
