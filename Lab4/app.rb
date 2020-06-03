# frozen_string_literal: true

require 'roda'
require 'date'
require 'forme'

require_relative 'models.rb'
# The core class of the web application for managing tests
class App < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :forme
  # plugin :hash_routes
  # plugin :path
  plugin :render
  plugin :status_handler
  # plugin :view_options
  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:trains] = TrainList.new(
    [
      Train.new(
        id: 12,
        number: 123,
        point_of_departure: 'Вологда',
        destination: 'Москва',
        departure_date: Date.parse('2011-01-18'),
        departure_time: '12:20',
        date_arrival: Date.parse('2011-01-18'),
        time_arrival: '20:12',
        price: '1200'
      ),
      Train.new(
        id: 1,
        number: 422,
        point_of_departure: 'Воркута',
        destination: 'Ярославль',
        departure_date: Date.parse('2013-01-14'),
        departure_time: '2:20',
        date_arrival: Date.parse('2013-01-16'),
        time_arrival: '22:12',
        price: '6200'
      )
    ]
  )

  status_handler(404) do
    view('not_found')
  end

  route do |r|
    r.public if opts[:serve_static]
    r.root do
      r.redirect '/trains'
    end
    r.on 'trains' do
      r.is do
        @parameters = DryResultFormeWrapper.new(DateIntervalFormSchema.call(r.params))
        if @parameters.success?
          @trains = opts[:trains].filter_interval_date(@parameters)
        else
          @trains = opts[:trains].all_trains
        end
        view('day_interval')
      end
    end
  end
end
