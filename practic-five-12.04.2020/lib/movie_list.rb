# frozen_string_literal: true

require 'csv'
require_relative 'movie.rb'

# array movie
class MovieList
  include Enumerable
  def initialize
    @movies = []
  end

  def getmovies
    @movies
  end

  def read_data(file)
   open_file = File.expand_path(file, __dir__)
    CSV.foreach(open_file, headers: true) do |row|
      @movies.push(Movie.new(
                     row['title'], row['kinopoisk'], row['imdb'],
                     row['metacritic'], row['rotten_tomatoes']
                   ))
    end
  end

  def save_sorted_list(file, array)
    write_file = File.expand_path(file, __dir__)
    CSV.open(write_file, 'wb') do |csv|
      csv << %w[title moviefire imdb kinopoisk metacritic rotten_tomatoes]
      array.each do |number|
        csv << [number.title, number.ogon_rating, number.rating_imdb, number.rating_kinopoisk,
                number.rating_metacritic, number.rating_rotten_tomatoes]
      end
    end
  end

  def each_movies
    @movies.each do |movie|
      yield movie
    end
  end

  def min_movies
    min = 1001
    @movies.each do |movie|
      min = movie.sum_rating if movie.sum_rating < min
    end
    @movies.each do |movie|
      return movie if movie.sum_rating == min
    end
  end

  def max_movies
    max = 0
    @movies.each do |movie|
      max = movie.sum_rating if movie.sum_rating > max
    end
    @movies.each do |movie|
      return movie if movie.sum_rating == max
    end
  end

  def count
    @movies.size
  end

  def reduce
    sum = 0
    @movies.each do |movie|
      sum += movie.sum_rating
    end
    sum
  end

  def average_ogon_rating
    reduce.to_f / (count.to_f * 5)
  end
end
