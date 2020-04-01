# frozen_string_literal: true

require_relative 'auto.rb'
require_relative 'fleet.rb'
require 'tty-prompt'
prompt = TTY::Prompt.new
object_one = Auto.new('BMW', 'X5 3,0D', 2017, 9.5845574007079)
object_two = Auto.new('Cherry', 'A5 2,0i', 2018, 8.759773242361172)
puts object_one
puts object_two
auto = Fleet.new
auto.add(object_one)
auto.add(object_two)
loop do
  brand = prompt.ask('Write brand auto : ', convert: :string, required: true)
  model = prompt.ask('Write model auto : ', convert: :string, required: true)
  manifacture_year = prompt.ask('Write manifacture year auto : ', convert: :int, required: true)
  gasoline_consumption = prompt.ask('Write gasoline consumption aut : ',
                                    convert: :float, required: true)
  object = Auto.new(brand, model, manifacture_year, gasoline_consumption)
  auto.add(object)
  break if prompt.yes?('Машина успешно добавлена, хотите закночить ввод машин?', required: true)
end

auto.load_from_file('NewDocument1.json')
puts auto.average_consumption
puts auto.number_by_brand('BMW')
puts auto.number_by_model('X5 3,0D')
puts auto.consumption_by_brand('Cherry')
