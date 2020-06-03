# frozen_string_literal: true

require_relative 'train.rb'

# The class that contains all our train
class TrainList
  def initialize(train = [])
    @trains = train.map do |tr|
      [tr.id, tr]
    end.to_h
  end

  def all_trains
    @trains
  end

  def trains_by_id(id)
    @trains[id]
  end

  def add_trains(parameters)
    train_id = if @trains.nil?
                 1
               else
                 @trains.keys.max + 1
               end
    @trains[train_id] = Train.new(
      id: train_id,
      number: parameters[:number],
      point_of_departure: parameters[:point_of_departure],
      destination: parameters[:destination],
      departure_date: parameters[:departure_date],
      departure_time: parameters[:departure_time],
      date_arrival: parameters[:date_arrival],
      time_arrival: parameters[:time_arrival],
      price: parameters[:price]
    )
    train_id
  end

  def update_trains(id, parameters)
    train = @trains[id]
    train.number = parameters[:number]
    train.point_of_departure = parameters[:point_of_departure]
    train.destination = parameters[:destination]
    train.departure_date = parameters[:departure_date]
    train.departure_time = parameters[:departure_time]
    train.date_arrival = parameters[:date_arrival]
    train.time_arrival = parameters[:time_arrival]
    train.price = parameters[:price]
  end

  def delete_trains(id)
    @trains.delete(id)
  end

  def filter_interval_date(parameters)
    first_date = Date.parse(parameters[:first_date])
    second_date = Date.parse(parameters[:second_date])
    @trains.to_a.select do |train|
      next unless check_first_date(train, first_date)
      next unless check_second_date(train, second_date)

      true
    end
  end

  def check_first_date(train, first_date)
    if train[1].departure_date.year.to_i > first_date.year.to_i
      true
    elsif train[1].departure_date.year.to_i == first_date.year.to_i
      if train[1].departure_date.mon.to_i > first_date.mon.to_i
        true
      elsif train[1].departure_date.mon.to_i == first_date.mon.to_i
        train[1].departure_date.mday.to_i >= first_date.mday.to_i
      end
    end
  end

  def check_second_date(train, second_date)
    if train[1].departure_date.year.to_i < second_date.year.to_i
      true
    elsif train[1].departure_date.year.to_i == second_date.year.to_i
      if train[1].departure_date.mon.to_i < second_date.mon.to_i
        true
      elsif train[1].departure_date.mon.to_i == second_date.mon.to_i
        train[1].departure_date.mday.to_i <= second_date.mday.to_i
      end
    end
  end
end
