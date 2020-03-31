# frozen_string_literal: true

require_relative 'my_complex.rb'
require "tty-prompt"
prompt = TTY::Prompt.new
object_one = MyComplex.new(13.2, 2)
object_two = MyComplex.new(24, 10)
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
while(1) do
    puts "Введите два комплексных числа"

    real = prompt.ask("Введите действительную часть  числа", convert: :int, required: true )
    puts real
    imaginary = prompt.ask("Введите мнимую часть  числа", convert: :int, required: true )
    puts imaginary
    object_one =MyComplex.new(real, imaginary)

    real = prompt.ask("Введите действительную часть  числа", convert: :int, required: true )
    puts real
    imaginary = prompt.ask("Введите мнимую часть  числа", convert: :int, required: true )
    puts imaginary
    object_two =MyComplex.new(real, imaginary)

    word = prompt.select("Choose your destiny?") do |menu|
     menu.enum '.'
  
     menu.choice 'add', 1
     menu.choice 'subtraction', 2
     menu.choice 'division', 3
     menu.choice 'multiplication', 4
  end
  case word
  when 1 
    object_new = object_one.add(object_two)
         puts object_new
  when 2
    object_new = object_one.subtraction(object_two)
         puts object_new
  when 3 
    object_new = object_one.division(object_two)
         puts object_new
  when 4
    object_new = object_one.multiplication(object_two)
         puts object_new
  end
   if(prompt.yes?('Хотите закночить програму?')) then return 
   end
end