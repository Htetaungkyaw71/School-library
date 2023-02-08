require './book'

describe Book do
  context 'Testing for Book class' do
    it 'Test title and author for Book class' do
      title = 'breaking bad'
      author = 'htet'

      book = Book.new(title, author)
      expect(book.title).to eq 'breaking bad'
      expect(book.author).to eq 'htet'
      expect(book.rentals).to eq []
    end
  end
end
