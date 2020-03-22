require_relative 'auto.rb'
require_relative 'fleet.rb'
object_one=Auto.new("BMW","X5 3,0D",2017,9.5845574007079)
object_two=Auto.new("Cherry","A5 2,0i",2018,8.759773242361172)
puts object_one.to_s
puts object_two.to_s
object_ine=add(object_one)
object_two.add
# load_from_file(C:\Temp\myproject\2020-spring-ruby\practice-two\NewDocument1.json)