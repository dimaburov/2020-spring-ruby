# frozen_string_literal: true

class Student
  def initialize(clas, name, point, score)
    @clas = clas
    @name = name
    @point = point
    @score = Integer(score)
  end
  attr_reader :clas
  attr_reader :name
  attr_reader :point
  attr_reader :score
  def to_s
    "#{clas} #{name} #{point} #{score}"
  end
end
