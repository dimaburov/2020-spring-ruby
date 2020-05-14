# frozen_string_literal: true

# class data books
class Diary
  def initialize(data, author, title)
    @data = data
    @author = author
    @title = title
  end
  attr_reader :data
  attr_reader :author
  attr_reader :title
end
