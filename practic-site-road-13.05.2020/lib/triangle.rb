# frozen_string_literal: true

# class data triangle
class Triangle
    def initialize(line_one, line_two, line_three)
        @line_one=line_one.to_f
        @line_two=line_two.to_f
        @line_three=line_three.to_f
    end
    attr_reader :line_one
    attr_reader :line_two
    attr_reader :line_three

    def triangle?
        return false  if @line_one+@line_two<@line_three
        return false  if @line_two+@line_three<@line_one
        return false  if @line_three+@line_one<@line_two
        true
    end
    
    def area
        if(triangle?) then
            p=(@line_one+@line_two+@line_three)/2
            return Math.sqrt(p*(p-@line_one)*
            (p-@line_two)*(p-@line_three))
            else return 0
        end
    end
end
