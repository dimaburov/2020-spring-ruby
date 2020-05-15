# frozen_string_literal: true

require 'forwardable'

require_relative 'diary.rb'
# The list of the diary
class DiaryList
  extend Forwardable
  def_delegator :@books, :each

  def initialize(book = [])
    @books = book
  end

  def add_books(book)
    @books.append(book)
  end

  def all_books
    @books.dup
  end

  def sort_by_data
    @books = @books.sort do |a, b|
      if (b.date.slice(0..3).to_i <=> a.date.slice(0..3).to_i).zero?
        if (b.date.slice(5..6).to_i <=> a.date.slice(5..6).to_i).zero?
          b.date.slice(8..9).to_i <=> a.date.slice(8..9).to_i
        else b.date.slice(5..6).to_i <=> a.date.slice(5..6).to_i
        end
      else b.date.slice(0..3).to_i <=> a.date.slice(0..3).to_i
      end
    end
  end

  def array_year
    array=[]
    year=0
    @books.each do |book|
     next if book.date.slice(0..3).to_i==year 
      year= book.date.slice(0..3).to_i
      array.append( year)
    end
    array
  end
end
