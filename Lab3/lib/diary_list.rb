# frozen_string_literal: true

require 'forwardable'

require_relative 'diary.rb'
# The list of the diary
class DiaryList
  extend Forwardable
  def_delegator :@triangles, :each

  def initialize(book = [])
    @books = book
  end

  def add_books(book)
    @books.append(book)
  end

  def all_books
    @books.dup
  end

  def sort_by_data; end
end
