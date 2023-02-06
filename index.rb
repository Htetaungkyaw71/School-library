require './app'


puts 'Welcome to School Library app!'

class Index
  def initialize
    @app = App.new
  end
  
  def run
    loop do
      Display.new.text
      id = gets.chomp.to_i
      case id
      when 1
        @app.list_all_books
      when 2
        @app.list_all_people
      when 3
        @app.create_person
      when 4
        @app.create_book
      when 5
        @app.create_rental
      when 6
        @app.show_rental
      else
        exit
      end
    end
  end
end

class Display
  def text
    puts ' '
    puts 'Please choose an option by enterin a number:'
    puts ' '
    puts '1 - List all books.'
    puts '2 - List all people.'
    puts '3 - Create a person.'
    puts '4 - Create a book.'
    puts '5 - Create a rental.'
    puts '6 - List all rentals for a given person id.'
    puts '7 - Exit.'
  end
end