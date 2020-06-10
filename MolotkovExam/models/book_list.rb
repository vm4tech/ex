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
      name: parameters[:name],
      description: parameters[:description],
      priority: parameters[:priority],
      last_update: parameters[:last_update],
      event_list: []
    )
    book_id
  end

  def update_book(id, parameters)
    
    book = @books[id]
    book.name = parameters[:name]
    book.description = parameters[:description]
    book.priority = parameters[:priority]
    book.last_update = parameters[:last_update]
    book.event_list = []
  end

  def delete_book(id)
    @books.delete(id)
  end
end