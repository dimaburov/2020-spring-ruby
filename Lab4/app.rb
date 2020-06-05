# frozen_string_literal: true

require 'roda'
require 'date'
require 'time'
require 'forme'

require_relative 'models.rb'
# The core class of the web application for managing tests
class App < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :forme
  plugin :hash_routes
  plugin :path
  plugin :render
  plugin :status_handler
  plugin :view_options
  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  require_relative 'routes/trains.rb'
  require_relative 'routes/cities.rb'

  opts[:trains] = TrainList.new(
    [
      Train.new(
        id: 12,
        number: 123,
        point_of_departure: 'Вологда',
        destination: 'Москва',
        departure_date_time: Time.new(2011, 1, 18, 12, 20),
        arrival_date_time: Time.new(2011, 1, 18, 20, 12),
        price: '1200'
      ),
      Train.new(
        id: 1,
        number: 422,
        point_of_departure: 'Воркута',
        destination: 'Ярославль',
        departure_date_time: Time.new(2013, 1, 14, 2, 20),
        arrival_date_time: Time.new(2013, 1, 16, 22, 12),
        price: '6200'
      ),
      Train.new(
        id: 13,
        number: 332,
        point_of_departure: 'Ярославль',
        destination: 'Москва',
        departure_date_time: Time.new(2011, 1, 18, 2, 20),
        arrival_date_time: Time.new(2011, 1, 18, 4, 12),
        price: '100'
      ),
      Train.new(
        id: 14,
        number: 313,
        point_of_departure: 'Москва',
        destination: 'Пермь',
        departure_date_time: Time.new(2011, 1, 18, 4, 20),
        arrival_date_time: Time.new(2011, 1, 22, 3, 23),
        price: '5000'
      )
    ]
  )

  status_handler(404) do
    view('not_found')
  end

  route do |r|
    r.public if opts[:serve_static]
    r.hash_branches
    r.root do
      r.redirect '/trains'
    end
  end
end
