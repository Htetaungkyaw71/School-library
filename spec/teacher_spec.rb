require './teacher'
require './classroom'

describe Teacher do
  context 'Testing for Teacher class' do
    it 'Test specialization, age for Teacher class' do
      age = 25
      specialization = 'prof'

      teacher = Teacher.new(specialization, age)

      expect(teacher.name).to eq 'Unknown'
      expect(teacher.age).to be > 18
      expect(teacher.id).to be > 0
    end

    it 'Test name and can_use_services for Teacher class' do
      age = 25
      specialization = 'prof'
      name = 'suzana'
      teacher = Teacher.new(specialization, age, name)
      use_services = teacher.can_use_services?
      expect(use_services).to be_truthy
      expect(teacher.age).to be > 18
      expect(teacher.id).to be > 0
      expect(teacher.name).to eq 'suzana'
    end
  end
end
