require './book'
require './student'
require './teacher'
require './rental'
require 'json'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def input_age_and_name
    print 'Age : '
    age = gets.chomp
    print 'Name : '
    name = gets.chomp
    [age, name]
  end

  def list(items, choose)
    if items.empty?
      puts "There is no #{choose}"
    elsif choose == 'book'
      items.map { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
    else
      items.map do |person|
        puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def list_all_books
    print @rentals
    list(@books, 'book')
  end

  def list_all_people
    list(@people, 'people')
  end

  def create_student
    input = input_age_and_name
    print 'Has parent permission? [y/n] : '
    permission = gets.chomp.downcase
    permission = permission == 'y'
    @people << Student.new(nil, input[0], input[1], permission)
  end

  def create_teacher
    input = input_age_and_name
    print 'Specializaion: '
    specialization = gets.chomp
    @people << Teacher.new(specialization, input[0], input[1])
  end

  def create_person
    print 'Do you want to create a student(1) or a teacher(2)? [Input the number]: '
    id = gets.chomp.to_i
    case id
    when 1
      create_student
      puts 'Person created successfully'
    when 2
      create_teacher
      puts 'Person created successfully'
    else
      puts 'Write Invalid number'
    end
  end

  def create_book
    print 'Title : '
    title = gets.chomp
    print 'Author : '
    author = gets.chomp
    @books << Book.new(title, author)
    puts 'Book created successfully'
  end

  def select_book
    puts 'Select a book from the following lists by number'
    @books.map.with_index { |book, index| puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}" }
    index_book = gets.chomp.to_i
    @books[index_book]
  end

  def select_person
    puts 'Select a person from the following lists by (Not Id)'
    @people.map.with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    index_person = gets.chomp.to_i
    @people[index_person]
  end

  def create_rental
    if @books.empty?
      puts 'There is no book'
    elsif @people.empty?
      puts 'There is no people'
    else
      rental_book = select_book
      rental_person = select_person
      print 'Date: '
      date = gets.chomp
      @rentals << Rental.new(date, rental_book, rental_person)
      puts 'Rental created successfully'
    end
  end

  def show_rental
    print 'ID of the person: '
    id = gets.chomp.to_i
    rentals = @rentals.select { |rental| rental.person.id == id }
    puts 'Rentals: '
    rentals.map { |rental| puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}." }
  end

  def save
    books = @books.map { |book| { title: book.title, author: book.author } }.to_json
    people = @people.map do |person|
      { id: person.id, age: person.age, name: person.name, rentals: person.rentals }
    end.to_json
    rentals = @rentals.map do |rental|
      {
        date: rental.date,
        book: {
          title: rental.book.title,
          author: rental.book.author,
          rentals: rental.book.rentals
        },
        person: {
          id: rental.person.id,
          name: rental.person.name,
          age: rental.person.age,
          rentals: rental.person.rentals
        }
      }
    end.to_json
    save_book = File.open('book.json', 'w')
    save_people = File.open('people.json', 'w')
    save_rentals = File.open('rentals.json', 'w')
    save_book.write(books)
    save_people.write(people)
    save_rentals.write(rentals)
  end

  def load
    loaded_book
    loaded_people
    loaded_rental
  end

  def loaded_book
    load_books = File.read('book.json') if File.exist?('book.json')
    json_books = JSON.parse(load_books)
    return if json_books.empty?

    new_books = json_books.map { |book| Book.new(book['title'], book['author']) }
    new_books.map { |book| @books << book }
  end

  def loaded_people
    load_people = File.read('people.json') if File.exist?('people.json')
    json_people = JSON.parse(load_people)
    return if json_people.empty?

    new_people = json_people.map { |person| Student.new(nil, person['age'], person['name'], true) }
    new_people.map { |person| @people << person }
  end

  def loaded_rental
    load_rentals = File.read('rentals.json') if File.exist?('rentals.json')
    json_rentals = JSON.parse(load_rentals)
    return if json_rentals.empty?

    new_rentals = json_rentals.map do |rental|
      Rental.new(
        rental['date'],
        Book.new(rental['book']['title'], rental['book']['author']),
        Student.new(nil, rental['person']['age'], rental['person']['name'], true)
      )
    end
    new_rentals.map { |rental| @rentals << rental }
  end
end
