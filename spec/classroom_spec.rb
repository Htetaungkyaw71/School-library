require './classroom'

describe Classroom do
  context 'Testing for Classroom class' do
    it 'Test label and students for Classroom class' do
      label = 'example'

      classroom = Classroom.new(label)
      expect(classroom.label).to eq 'example'
    end
  end
end
