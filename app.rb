require './book'
require './student'
require './teacher'
require './rental'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_all_books
    if @books.empty?
      puts 'There is no book'
    else
      @books.map { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
    end
  end

  def list_all_people
    if @people.empty?
      puts 'There is no people'
    else
      @people.map do |person|
        puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def input_age_and_name
    print 'Age : '
    age = gets.chomp
    print 'Name : '
    name = gets.chomp
    [age, name]
  end

  def create_person
    print 'Do you want to create a student(1) or a teacher(2)? [Input the number]: '
    id = gets.chomp.to_i
    case id
    when 1
      input = input_age_and_name
      print 'Has parent permission? [y/n] : '
      permission = gets.chomp.downcase
      permission = permission == 'y'
      @people << Student.new(nil, input[0], input[1], permission)
      puts 'Person created successfully'
    when 2
      input = input_age_and_name
      print 'Specializaion: '
      specialization = gets.chomp
      @people << Teacher.new(specialization, input[0], input[1])
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

  def create_rental
    if @books.empty?
      puts 'There is no book'
    elsif @people.empty?
      puts 'There is no people'
    else
      puts 'Select a book from the following lists by number'
      @books.map.with_index { |book, index| puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}" }
      index_book = gets.chomp.to_i
      rental_book = @books[index_book]


      puts 'Select a person from the following lists by (Not Id)'
      @people.map.with_index do |person, index|
        puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
      index_person = gets.chomp.to_i
      rental_person = @people[index_person]

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
end
