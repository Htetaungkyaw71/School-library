require './rental'
require './person'
require './book'

describe Rental do
  context 'Testing for Rental class' do
    it 'Test date, book and person  for Rental class' do
      date = '1/1/2023'
      person = Person.new(20)
      book = Book.new('test_title', 'test_author')


      rental = Rental.new(date, book, person)
      expect(rental.date).to eq '1/1/2023'
      expect(rental.book).to be_a_kind_of(Book)
      expect(rental.person).to be_a_kind_of(Person)
    end
  end
end
