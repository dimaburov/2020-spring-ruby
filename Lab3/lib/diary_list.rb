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

  def sort_by_data
    # arr=[]
    # @books.map { |book|  book.data.each_line('-') { |s|  array.append(s.delete "-")}}
    # array=@books.sort {|a,b|  a.data<=>b.data}
    # arr= @books.sort { |a, b|  b.data.each_line('-'){ |s|  s.delete "-"}.to_i<=>a.data.each_line('-') { |s| s.delete "-"}.to_i }
    # array=[]
    # array= arr.sort {|a,b| b.data.each_line('-'){ |s|  s.delete "-"}.to_i<=>a.data.each_line('-') { |s| s.delete "-"}.to_i }
    # @books.map do |book|
    #     p array.append(book.data.slice(8..9))
    # end
    @books= @books.sort do |a, b| 
        if (b.data.slice(0..3).to_i<=>a.data.slice(0..3).to_i)==0 then
            if (b.data.slice(5..6).to_i<=>a.data.slice(5..6).to_i)==0 then
                b.data.slice(8..9).to_i<=>a.data.slice(8..9).to_i
            else b.data.slice(5..6).to_i<=>a.data.slice(5..6).to_i
            end
        else b.data.slice(0..3).to_i<=>a.data.slice(0..3).to_i
        end 
    end
    p @books
    # arr= arr.sort {|a,b| b.data.slice(5..6).to_i<=>a.data.slice(5..6).to_i}
    # p arr
    # arr= arr.sort {|a,b| b.data.slice(8..9).to_i<=>a.data.slice(8..9).to_i}
    # p arr 
  end
end
