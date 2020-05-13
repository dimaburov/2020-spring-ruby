# frozen_string_literal: true

# Validators for the incoming requests
module InputValidators
    def self.check_min_and_max(raw_min, raw_max)
        min= raw_min || ''
        max= raw_max || ''
        error=[]
        if  min.empty? then  error.append("Поле с min значение не должно быть пустым")
        else error.concat(check_format_min(min))
        end
        if max.empty? then error.append("Поле с max значение не должно быть пустым")
        else error.concat(check_format_max(max))
        end
        if min.to_i>max.to_i then 
            error.append(" Минимальное значение не должно быть больше максимального")
        end
        {
            min: min,
            max: max,
            error: error
        }
    end
    def self.check_format_min(min)
        if /\d/ =~ min
            []
        else 
            ['Минимальное значение должно быть цифрой']
        end
    end
    def self.check_format_max(max)
        if /\d/ =~ max
            []
        else 
            ['Максимальное значение должно быть цифрой']
        end
    end


    def check_side_lengths(raw_line_one, raw_line_two, raw_line_three)
        line_one= raw_line_one || ''
        line_two= raw_line_two || ''
        line_three= raw_line_three || ''
        error = [].concat(check_line_one(line_one))
               .concat(check_line_two(line_two))
               .concat(check_line_three(line_three))
        {
            line_one: line_one,
            line_two: kine_two,
            line_three: line+three,
            error: error
        }
    end
    def check_line(line)
        if line_one.empty?
            ['Поле с размером первой стороны не может быть пустым']
          else
            []
          end
    end
    def check_line_two(line_two)
        if line_two.empty?
            ['Поле с размером второй стороны не может быть пустым']
          else
            []
          end
    end
    def check_line_three(line_three)
        if line_three.empty?
            ['Поле с размером третей стороны не может быть пустым']
          else
            []
          end
    end
end