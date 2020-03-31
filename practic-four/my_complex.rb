# frozen_string_literal: true

# works with complex numbers
class MyComplex
  def initialize(real, imaginary)
    @real = real
    @imaginary = imaginary
  end

  def to_s
    "#{@real} + i*#{@imaginary}"
  end

  attr_reader :real

  attr_reader :imaginary

  def add(other)
    MyComplex.new(@real.to_f + other.real.to_f, @imaginary.to_f + other.imaginary.to_f)
  end

  def subtraction(other)
    MyComplex.new(@real.to_f - other.real.to_f, @imaginary - other.imaginary.to_f)
  end

  def division(other)
    MyComplex.new(@real / other.real, @imaginary / other.imaginary)
  end

  def multiplication(other)
    MyComplex.new(@real.to_f * other.real.to_f, @imaginary.to_f * other.imaginary.to_f)
  end
end
