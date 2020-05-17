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
    array = []
    year = 0
    @books.each do |book|
      next if book.date.slice(0..3).to_i == year

      year = book.date.slice(0..3).to_i
      array.append(year)
    end
    array
  end

  def check_month2(month)
    return 'Октябрь' if month == '10'
    return 'Ноябрь' if month == '11'
    return 'Декабрь' if month == '12'
  end

  def check_month1(month)
    return 'Июнь' if month == '06'
    return 'Июль' if month == '07'
    return 'Август' if month == '08'
    return 'Сентябрь' if month == '09'

    check_month2(month)
  end

  def check_month(month)
    return 'Январь' if month == '01'
    return 'Февраль' if month == '02'
    return 'Март' if month == '03'
    return 'Апрель' if month == '04'
    return 'Май' if month == '05'

    check_month1(month)
  end

  def array_count(year)
    months = Hash.new(0)
    (1..12).each do |hash|
      if hash > 9
        months[check_month(hash.to_s)] += 0
      else
        months[check_month("0#{hash}")] += 0
      end
    end
    month = ''
    @books.each do |book|
      if book.date.slice(0..3) == year
        month = book.date.slice(5..6)
        break
      end
    end
    count = 0
    @books.each do |book|
      next unless book.date.slice(0..3) == year

      count += 1 if book.date.slice(5..6) == month
      next if book.date.slice(5..6) == month

      months[check_month(month)] += count
      month = book.date.slice(5..6)
      count = 1
    end
    months[check_month(month)] += count
    months.to_a
  end
end
