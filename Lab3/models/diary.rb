# frozen_string_literal: true

# class data books
class Diary
  def initialize(date, author, title, point, formats, size, txt)
    @date = date
    @author = author
    @title = title
    @point = point
    @formats = formats
    @size = size
    @txt = txt
  end
  attr_reader :date
  attr_reader :author
  attr_reader :title
  attr_reader :point
  attr_reader :formats
  attr_reader :size
  attr_reader :txt
end
