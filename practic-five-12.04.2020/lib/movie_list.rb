# frozen_string_literal: true

require 'csv'
require_relative 'movie.rb'

# array movie
class MovieList
  def initialize
    @movies = []
  end

  def getmovies
    @movies
  end

  def read_data(file)
    CSV.foreach(file, headers: true) do |row|
      @movies.push(Movie.new(
                     row['title'], row['kinopoisk'], row['imdb'],
                     row['metacritic'], row['rotten_tomatoes']
                   ))
    end
  end

  def save_sorted_list(file, array)
    CSV.open(file, 'wb') do |csv|
      csv << %w[title moviefire imdb kinopoisk metacritic rotten_tomatoes]
      array.each do |number|
        csv << [number.title, number.ogon_rating, number.rating_imdb, number.rating_kinopoisk,
                number.rating_metacritic, number.rating_rotten_tomatoes]
      end
    end
  end
end
