require_relative 'my_complex.rb'
object_one=MyComplex.new(13,2)
object_two=MyComplex.new(24,10)
pp object_one
p object_one
pp object_two
p object_two
puts object_one
puts object_two
puts object_one.real
puts object_one.imaginary
puts object_two.real
puts object_two.imaginary
object_new= object_one.add(object_two)
puts object_new
