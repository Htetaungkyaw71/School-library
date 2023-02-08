require './student'
require './classroom'

describe Student do
  context 'Testing for Student class' do
    it 'Test classroom age, name, parent_permission for Student class' do
      age = 25
      name = 'htet'
      classroom = nil
      parent_permission = true

      student = Student.new(classroom, age, name, parent_permission)

      expect(student.name).to eq 'htet'
      expect(student.age).to be > 18
    end
  end
end
