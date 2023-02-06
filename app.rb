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

  def input_age_and_name
    print 'Age : '
    age = gets.chomp
    print 'Name : '
    name = gets.chomp
    [age, name]
  end

  def list (items,choose)
    if items.empty?
        puts "There is no #{choose}"
    else
      if choose == "book"
        items.map { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
      else
        items.map do |person|
          puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
        end
      end
    end
  end


  def list_all_books
    list(@books, "book")
    # if @books.empty?
    #   puts 'There is no book'
    # else
    #   @books.map { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
    # end
  end

  def list_all_people
    list(@people, "people")
    # if @people.empty?
    #   puts 'There is no people'
    # else
    #   @people.map do |person|
    #     puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    #   end
    # end
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
      # input = input_age_and_name
      # print 'Has parent permission? [y/n] : '
      # permission = gets.chomp.downcase
      # permission = permission == 'y'
      # @people << Student.new(nil, input[0], input[1], permission)
      puts 'Person created successfully'
    when 2
      create_teacher
      # input = input_age_and_name
      # print 'Specializaion: '
      # specialization = gets.chomp
      # @people << Teacher.new(specialization, input[0], input[1])
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
    rental_book = @books[index_book]
    rental_book
  end

  def select_person
    puts 'Select a person from the following lists by (Not Id)'
    @people.map.with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    index_person = gets.chomp.to_i
    rental_person = @people[index_person]
    rental_person
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
      # puts 'Select a book from the following lists by number'
      # @books.map.with_index { |book, index| puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}" }
      # index_book = gets.chomp.to_i
      # rental_book = @books[index_book]


      # puts 'Select a person from the following lists by (Not Id)'
      # @people.map.with_index do |person, index|
      #   puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      # end
      # index_person = gets.chomp.to_i
      # rental_person = @people[index_person]

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
