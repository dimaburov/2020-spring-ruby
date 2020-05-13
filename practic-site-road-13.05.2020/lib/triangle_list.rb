require 'forwardable'

require_relative 'triangle.rb'
# The list of the triangle
class TriangleList
    extend Forwardable
    def_delegator :@triangles, :each

    def initialize(triangle = [])
        @triangles = triangle
    end
    
    def add_triangle(triangle)
        @triangles.append(triangle)
    end 

    def all_triangle
        @triangles.dup
    end
    
    def triangles_by_area(min, max)
        @triangles.select do |triangle|
            puts "area :#{triangle.area}"
            puts "triangle: #{triangle.line_one}  #{triangle.line_two}  #{triangle.line_three}"
            puts "min :#{min.to_f}"
            puts "max :#{max.to_f}"
            next if triangle.area>max.to_f
            next if triangle.area<min.to_f
            
            true
        end
    end

end