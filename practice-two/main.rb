require_relative 'auto.rb'
require_relative 'fleet.rb'
object_one=Auto.new("BMW","X5 3,0D",2017,9.5845574007079)
object_two=Auto.new("Cherry","A5 2,0i",2018,8.759773242361172)
puts object_one
puts object_two
object=Fleet.new()
object.add(object_one)
object.add(object_two)
object.load_from_file('NewDocument1.json')
puts object.average_consumption
puts object.number_by_brand("BMW")
puts object.number_by_model("X5 3,0D")
puts object.consumption_by_brand("Cherry")