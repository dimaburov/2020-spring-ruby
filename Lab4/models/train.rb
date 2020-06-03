# frozen_string_literal: true

# The information about the good landing
Train = Struct.new(:id, :number, :point_of_departure, :destination, :departure_date, :departure_time, :date_arrival, :time_arrival, :price, keyword_init: true)
