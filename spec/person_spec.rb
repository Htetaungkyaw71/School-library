require './person'

describe Person do
  context 'Testing for Person class' do
    it 'Test age for Person class' do
      age = 20

      person = Person.new(age)
      can_use = person.can_use_services?
      expect(person.age).to be > 18
      expect(person.name).to eq 'Unknown'
      expect(person.id).to be_between(1, 1000)
      expect(can_use).to be_truthy
    end

    it 'Test name for Person class' do
      age = 22
      name = 'david'

      person = Person.new(age, name)
      can_use = person.can_use_services?
      expect(person.age).to be > 20
      expect(person.name).to eq 'david'
      expect(person.id).to be_between(1, 1000)
      expect(can_use).to be_truthy
    end

    it 'Test correct name for Person class' do
      age = 22
      name = 'longer_example_name'

      person = Person.new(age, name)
      can_use = person.can_use_services?
      expect(person.age).to be > 20
      expect(person.name).to eq 'longer_example_name'
      expect(person.id).to be_between(1, 1000)
      expect(can_use).to be_truthy
      expect(person.name).not_to eq 'Longer_exa'
    end
  end
end
