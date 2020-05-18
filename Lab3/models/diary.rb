# frozen_string_literal: true

# class data books
class Diary
  def initialize(date, author, title)
    @date = date
    @author = author
    @title = title
  end
  attr_reader :date
  attr_reader :author
  attr_reader :title
end
