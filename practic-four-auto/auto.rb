# frozen_string_literal: true

# data auto
class Auto
  def initialize(brand, model, manifacture_year, gasoline_consumption)
    @brand = brand
    @model = model
    @manifacture_year = manifacture_year
    @gasoline_consumption = gasoline_consumption
  end

  attr_reader :brand

  attr_reader :model

  attr_reader :manifacture_year

  attr_reader :gasoline_consumption

  def to_s
    "\n\t\tbrand :  #{brand}
                model :  #{model}
                year :  #{manifacture_year}
                consumption :  #{gasoline_consumption}"
  end
end
