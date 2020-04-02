# frozen_string_literal: true

require_relative 'my_complex.rb'
require 'tty-prompt'
require 'chunky_png'
prompt = TTY::Prompt.new
object=[]
object_one = MyComplex.new(13.2, 2)
object.push(object_one)
object_two = MyComplex.new(24, 10)
object.push(object_two)
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
puts 'Write two complex number'
loop do
  real = prompt.ask('Write real number', convert: :float, required: true)
  imaginary = prompt.ask('Write imaginary number', convert: :float, required: true)
  object_one = MyComplex.new(real, imaginary)
  object.push(object_one)
  real = prompt.ask('Write real number', convert: :float, required: true)
  imaginary = prompt.ask('Write imaginary number', convert: :float, required: true)
  object_two = MyComplex.new(real, imaginary)
  object.push(object_two)
  word = prompt.select('Choose your destiny?') do |menu|
    menu.enum '.'
    menu.choice 'add', 1
    menu.choice 'subtraction', 2
    menu.choice 'division', 3
    menu.choice 'multiplication', 4
  end
  case word
  when 1
    object_new = object_one.add(object_two)
    object.push(object_new)
  when 2
    object_new = object_one.subtraction(object_two)
    object.push(object_new)
  when 3
    object_new = object_one.division(object_two)
    object.push(object_new)
  when 4
    object_new = object_one.multiplication(object_two)
    object.push(object_new)
  end
  puts object_new
  break if prompt.yes?('Хотите закночить програму?')
end
  png= ChunkyPNG::Image.new(100,100,ChunkyPNG::Color::WHITE)
  png.line_xiaolin_wu(50, 100, 50, 0, stroke_color= ChunkyPNG::Color::BLACK, inclusive = true)
  png.line_xiaolin_wu(0, 50, 100, 50, stroke_color= ChunkyPNG::Color::BLACK, inclusive = true)

  # for number in 0..50
  #   break if number==50 
  #   next if number.even? 
  # png.line_xiaolin_wu(0+number, 49, 0+number, 51, stroke_color=ChunkyPNG::Color::BLACK, inclusive = true)
  # end
  object.each_with_index do |number,index|
    png.compose_pixel(50+object[index].real,50- object[index].imaginary, color= ChunkyPNG::Color(0x7b0f34FF))
  end

  png.save('filename.png', :interlace => true)

