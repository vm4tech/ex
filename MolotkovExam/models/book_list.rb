# frozen_string_literal: true

require_relative 'book'

# The class that contains all our books
class BookList
  def initialize(books = [])
    @books = books.map do |book|
      [book.id, book]
    end.to_h
  end

  def all_books
    @books.values
  end

  def book_by_id(id)
    @books[id]
  end

  def add_book(parameters)
    book_id = @books.keys.max + 1
    @books[book_id] = Book.new(
      id: book_id,
      title: parameters[:name],
      description: parameters[:description],
      start_time: parameters[:start_time],
      end_time: parameters[:end_time]
    )
    pp parameters[:title]
    book_id
  end

  def update_book(id, parameters)
    
    book = @books[id]
    book.title = parameters[:name]
    book.description = parameters[:description]
    book.start_time = parameters[:start_time]
    book.end_time = parameters[:end_time]
  
  end

  def delete_book(id)
    @books.delete(id)
  end
end