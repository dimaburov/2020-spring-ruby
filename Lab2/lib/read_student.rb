# frozen_string_literal: true

require 'csv'

require_relative 'student_list.rb'
require_relative 'student.rb'
module ReadStudent
  File = File.expand_path('../data/test_results.csv', __dir__)
  def self.read_match
    student_list = StudentList.new
    CSV.foreach(File, headers: true) do |row|
      point = row[2].to_s
      student_list.add(Student.new(
                         row[0], row[1],
                         row[2], point_score(point)
                       ))
    end
    student_list
  end

  def self.point_score(point)
    count = 0
    (0..point.size).each do |number|
      count += 1 if point[number] == '1'
    end
    count
  end
end
