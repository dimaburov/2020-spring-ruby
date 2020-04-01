# frozen_string_literal: true

# work in auto
class Fleet
  def initialize
    @cars = []
  end

  def add(car)
    @cars.push(car)
  end

  def load_from_file(file_name)
    require 'json'
    json_data = File.read(file_name)
    ruby_objects = JSON.parse(json_data)
    kol = 0
    while ruby_objects.size != kol
      add(Auto.new(ruby_objects[kol]['mark'], ruby_objects[kol]['model'],
                   ruby_objects[kol]['year'], ruby_objects[kol]['consumption']))
      kol += 1
    end
  end

  def average_consumption
    kol = 0
    sumall = 0.0
    while @cars.size != kol
      sumall = @cars[kol].gasoline_consumption.to_f + sumall
      kol += 1
    end
    sumall / @cars.size
  end

  def number_by_brand(brand)
    count = 0
    kol = 0
    while @cars.size != kol
      count += 1 if @cars[kol].brand == brand
      kol += 1
    end
    count
  end

  def number_by_model(model)
    count = 0
    kol = 0
    while @cars.size != kol
      count += 1 if @cars[kol].model == model
      kol += 1
    end
    count
  end

  def consumption_by_brand(brand)
    count = 0
    allsum = 0.0
    kol = 0
    while @cars.size != kol
      if @cars[kol].brand == brand
        allsum = @cars[kol].gasoline_consumption.to_f + allsum
        count += 1
      end
      kol += 1
    end
    allsum / count
  end
end
