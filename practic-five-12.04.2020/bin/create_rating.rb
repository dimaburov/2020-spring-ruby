# frozen_string_literal: true

require_relative '../lib/raiting_creator.rb'
object = RatingCreator.new
object.create
object.show_min_max
# object.list_movies
object.show_rating
