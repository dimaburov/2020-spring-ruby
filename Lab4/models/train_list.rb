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

  def all_real_trains
    @trains.values
  end

  def trains_by_id(id)
    @trains[id]
  end

  def add_trains(parameters)
    train_id = if @trains.empty?
                 1
               else
                 @trains.keys.max + 1
               end
    @trains[train_id] = Train.new(
      id: train_id,
      number: parameters[:number],
      point_of_departure: parameters[:point_of_departure],
      destination: parameters[:destination],
      departure_date_time: Time.new(parameters[:departure_date].year,
                                    parameters[:departure_date].mon,
                                    parameters[:departure_date].mday,
                                    parameters[:departure_time].hour,
                                    parameters[:departure_time].min),
      arrival_date_time: Time.new(parameters[:arrival_date].year,
                                  parameters[:arrival_date].mon,
                                  parameters[:arrival_date].mday,
                                  parameters[:arrival_time].hour,
                                  parameters[:arrival_time].min),
      price: parameters[:price]
    )
    @trains[train_id]
  end

  def add_real_trains(train)
    @trains[train.id] = train
  end

  def delete_trains(id)
    @trains.delete(id)
  end

  def filter_interval_date(parameters)
    @trains.to_a.select do |train|
      next unless check_first_date(train, parameters)
      next unless check_second_date(train, parameters)

      true
    end
  end

  def check_first_date(train, parameters)
    if train[1].departure_date_time.year.to_i > parameters[:first_date].year.to_i
      true
    elsif train[1].departure_date_time.year.to_i == parameters[:first_date].year.to_i
      if train[1].departure_date_time.mon.to_i > parameters[:first_date].mon.to_i
        true
      elsif train[1].departure_date_time.mon.to_i == parameters[:first_date].mon.to_i
        train[1].departure_date_time.mday.to_i >= parameters[:first_date].mday.to_i
      end
    end
  end

  def check_second_date(train, parameters)
    if train[1].departure_date_time.year.to_i < parameters[:second_date].year.to_i
      true
    elsif train[1].departure_date_time.year.to_i == parameters[:second_date].year.to_i
      if train[1].departure_date_time.mon.to_i < parameters[:second_date].mon.to_i
        true
      elsif train[1].departure_date_time.mon.to_i == parameters[:second_date].mon.to_i
        train[1].departure_date_time.mday.to_i <= parameters[:second_date].mday.to_i
      end
    end
  end

  def full_filter(parameters)
    @trains.to_a.select do |train|
      next unless train[1].point_of_departure == parameters[:point_of_departure]
      next unless train[1].destination == parameters[:destination]
      next unless check_date(parameters, train)
      unless train[1].price.to_i > parameters[:price_min].to_i &&
             train[1].price.to_i < parameters[:price_max].to_i
        next
      end

      true
    end
  end

  def check_date(parameters, train)
    if train[1].departure_date_time.year == parameters[:departure_date].year
      if train[1].departure_date_time.mon == parameters[:departure_date].mon
        train[1].departure_date_time.mday == parameters[:departure_date].mday
      else
        false
      end
    else
      false
    end
  end

  def check_live_city
    city = []
    @trains.each do |train|
      next if check_destination(train)

      city.append(train[1].destination)
    end
    city.uniq
  end

  def check_destination(train)
    flag = false
    @trains.each do |tr|
      flag = true if tr[1].point_of_departure == train[1].destination
    end
    flag
  end

  def all_cities
    city = []
    @trains.each do |train|
      city.append(train[1].point_of_departure)
      city.append(train[1].destination)
    end
    city.uniq
  end

  def max_path(parameters)
    max = 0
    train_filter = @trains.to_a.select do |train|
      next unless check_date(parameters, train) || check_date_destination(parameters, train)

      if parameters[:city] == train[1].point_of_departure
        true
      elsif parameters[:city] == train[1].destination
        true
      else next
      end
    end
    train_filter.each do |train|
      max_check = check_path(train, train_filter, parameters)
      max = max_check if max_check > max
    end
    max
  end

  def check_path(train, train_filter, parameters)
    count = 0
    min_max = period_of_time(train, parameters)
    train_filter.each do |tr|
      min_max_sravn = period_of_time(tr, parameters)
      if min_max[0] <= min_max_sravn[0] && min_max[1] >= min_max_sravn[0]
        count += 1
      elsif  min_max[0] <= min_max_sravn[1] && min_max[1] >= min_max_sravn[1]
        count += 1
      end
    end
    count
  end

  def period_of_time(train, parameters)
    min_max = []
    if check_date(parameters, train)
      if parameters[:city] == train[1].point_of_departure
        min_max.append(train[1].departure_date_time - (60 * 30))
        min_max.append(train[1].departure_date_time)
      end
    end
    if check_date_destination(parameters, train)
      if parameters[:city] == train[1].destination
        min_max.append(train[1].arrival_date_time)
        min_max.append(train[1].arrival_date_time + (60 * 30))
      end
    end
    min_max
  end

  def check_date_destination(parameters, train)
    if train[1].arrival_date_time.year == parameters[:departure_date].year
      if train[1].arrival_date_time.mon == parameters[:departure_date].mon
        train[1].arrival_date_time.mday == parameters[:departure_date].mday
      else
        false
      end
    else
      false
    end
  end
end
