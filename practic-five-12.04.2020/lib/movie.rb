# frozen_string_literal: true

# movie data
class Movie
  include Comparable
  def initialize(title, rating_imdb, rating_kinopoisk,
                 rating_metacritic, rating_rotten_tomatoes)
    @title = title
    @rating_imdb = rating_imdb
    @rating_kinopoisk = rating_kinopoisk
    @rating_metacritic = rating_metacritic
    @rating_rotten_tomatoes = rating_rotten_tomatoes
  end
  attr_reader :title
  attr_reader :rating_imdb
  attr_reader :rating_kinopoisk
  attr_reader :rating_metacritic
  attr_reader :rating_rotten_tomatoes
  def ogon_rating
    (rating_imdb.to_f + rating_kinopoisk.to_f + (rating_metacritic.to_f +
     rating_rotten_tomatoes.to_f) / 2) / 3
  end

  def <=>(other)
    ogon_rating <=> other.ogon_rating
  end

  def to_s
    "#{@title}: #{ogon_rating}, #{@rating_imdb},
     #{@rating_kinopoisk}, #{@rating_metacritic}, #{@rating_rotten_tomatoes}"
  end

  def sum_rating
    ogon_rating.to_f + rating_imdb.to_f + rating_metacritic.to_f +
      rating_kinopoisk.to_f + rating_rotten_tomatoes.to_f
  end
end
