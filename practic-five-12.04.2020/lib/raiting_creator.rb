# frozen_string_literal: true

require 'getoptlong'
require_relative 'movie_list.rb'

# handling of arguments
class RatingCreator
  def initialize
    @movie_list = MovieList.new
  end

  def create
    if ARGV[0] == '--help'
      puts "\t    ... ruby main.rb --input.csv  --sorted.csv
              exampl ... ruby main.rb ../data/input.scv ../data/sorted.csv
             --help: displays how to enter data
             --input.csv : path to the file where data is stored
             --sorted.scv : path to the file where the sorted data will be stored"
      return
    end
    if(File.file? ARGV[0]) then
    else 
      puts "Файл не найден"
      exit
    end
    if ARGV.length < 2
      puts "Передано недостаточно аргументов"
      exit
    end
    @movie_list.read_data(ARGV[0])
    @movie_list.save_sorted_list(ARGV[1], @movie_list.getmovies.sort)
  end

  def show_min_max
    puts @movie_list.min_movies
    puts @movie_list.max_movies
  end

  # def list_movies
  #   @movie_list.each_movies.with_index do |movie, index|
  #     puts "#{index} #{movie}"
  #   end
  # end
  def show_rating
    puts "Среднее значение рейтинга фильмов = #{@movie_list.average_ogon_rating}"
  end
end
