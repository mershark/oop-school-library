module PersonManager
  def create_student(age, name)
    permission = parent_permission_prompt
    classroom = classroom_prompt
    parent_permission = permission == 'y'
    student = Student.new(age, classroom, name, parent_permission: parent_permission)
    @people << student
    puts 'Student Created Successfully'
    save_people('people.json', @people)
  end

  def create_teacher(age, name)
    print 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name)
    @people << teacher
    puts 'Teacher Created Successfully'
    save_people('people.json', @people)
  end

  def parent_permission_prompt
    print 'Parent Permission (y/n): '
    gets.chomp
  end

  def classroom_prompt
    print 'Classroom: '
    gets.chomp
  end
end
