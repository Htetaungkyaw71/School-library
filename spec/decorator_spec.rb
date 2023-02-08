require './decorator'
require './person'

describe CapitalizeDecorator do
  context 'Testing for CapitalizeDecorator class' do
    it 'Test correct_name for CapitalizeDecorator class' do
      person = Person.new(22, 'htet')

      capit = CapitalizeDecorator.new(person)

      expect(capit.correct_name).to eq 'Htet'
    end
  end
end

describe TrimmerDecorator do
  context 'Testing for TrimmerDecorator class' do
    it 'Test correct_name for TrimmerDecorator class' do
      person = Person.new(22, 'Longer_name_test')

      capit = TrimmerDecorator.new(person)

      expect(capit.correct_name).to eq 'Longer_nam'
    end
  end
end
