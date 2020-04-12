# frozen_string_literal: true

require 'getoptlong'
require_relative 'movie_list.rb'

# handling of arguments
class RatingCreator
  def create
    if ARGV[0] == '--help'
      puts "\t    ... ruby main.rb --input.csv  --sorted.csv
              exampl ... ruby main.rb ../data/input.scv ../data/sorted.csv
             --help: displays how to enter data
             --input.csv : path to the file where data is stored
             --sorted.scv : path to the file where the sorted data will be stored"
      return
    end
    movie_list = MovieList.new
    movie_list.read_data(ARGV[0])
    movie_list.save_sorted_list(ARGV[1], movie_list.getmovies.sort)
  end
end
