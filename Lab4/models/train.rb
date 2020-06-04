# frozen_string_literal: true

# The information about the good landing
Train = Struct.new(:id, :number, :point_of_departure, :destination, :departure_date_time,
                   :arrival_date_time, :price, keyword_init: true)
