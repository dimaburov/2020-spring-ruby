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
        departure_date_time: Time.new(2013, 3, 14, 2, 20),
        arrival_date_time: Time.new(2013, 3, 14, 4, 12),
        price: '100'
      ),
      Train.new(
        id: 14,
        number: 313,
        point_of_departure: 'Вологда',
        destination: 'Пермь',
        departure_date_time: Time.new(2018, 3, 14, 2, 2),
        arrival_date_time: Time.new(2018, 3, 16, 3, 23),
        price: '5000'
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
        @trains = if @parameters.success?
                    opts[:trains].filter_interval_date(@parameters)
                  else
                    opts[:trains].all_trains
                  end
        view('day_interval')
      end
      r.on 'live_the_city' do
        r.get do
          @cities = opts[:trains].check_live_city
          view('live_the_city')
        end
      end
      r.on 'all_cities' do
        r.get do
          @cities = opts[:trains].all_cities
          view('all_cities')
        end
      end
      r.on Integer do |train_id|
        @trains = opts[:trains].trains_by_id(train_id)
        next if @trains.nil?

        r.on 'day_interval' do
          view('information_train_day_interval')
        end

        r.on 'full_filter' do
          view('information_train_full_filter')
        end

        r.on 'delete' do
          r.get do
            @parameters = {}
            view('train_delete')
          end

          r.post do
            @parameters = DryResultFormeWrapper.new(TrainDeleteSchema.call(r.params))
            if @parameters.success?
              opts[:trains].delete_trains(@trains.id)
              r.redirect('/trains')
            else
              view('train_delete')
            end
          end
        end
      end
      r.on 'new' do
        r.get do
          @parameters = {}
          view('train_new')
        end

        r.post do
          @parameters = DryResultFormeWrapper.new(TrainNewFormSchema.call(r.params))
          if @parameters.success?
            train_id = opts[:trains].add_trains(@parameters)
            r.redirect "/trains/#{train_id}"
          else
            view('train_new')
          end
        end
      end
      r.on 'filter' do
        r.get do
          @parameters = DryResultFormeWrapper.new(FullFilterFormSchema.call(r.params))
          @trains = if @parameters.success?
                      opts[:trains].full_filter(@parameters)
                    else
                      opts[:trains].all_trains
                    end
          view('train_full_filter')
        end
      end
    end
  end
end
