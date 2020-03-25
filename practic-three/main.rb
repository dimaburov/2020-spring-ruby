def main
  array = input_data
         solve_with_cycles(array)
#   solve_with_iterators(array)
end

def input_data
  [12, -56, 77, 0,8,0,-2]
end
def get_znak(number)
    if(number.to_i>=0) then return  1
        elsif(number.to_i<0) then return   -1
    end
    return 0
end
def solve_with_cycles(array)
    count=0
    for number in 0..array.size
         if(number==array.size) then  
             break
         end
        if(get_znak(array[number])!=get_znak(array[number+1])) then 
          count=count+1
          puts "Индексы смены знака #{number} и #{number+1}"
        end
    end
    puts "Количество смены знака #{count}"

    for number in 0..array.size
        index=number
        while(index.modulo(2)==0) 
            index=index.to_f/2
            if(index==0)then  break
            end
            if(index==1)then  puts array[number] end
        end
    end

    puts "Введите точку в которой необходимо посчитать функцию x: "
    print ">>"
    x=gets.strip
    fuction=0.0
    for number in 0..array.size
        fuction=fuction+array[number].to_f*x.to_f**number.to_f
    end
    puts "Значение функции в точке #{x} равно #{fuction}"
    fuction=0.0
    for number in 1..array.size
        fuction=fuction+array[number].to_f*number.to_f*x.to_f**(number.to_f-1)
    end
    puts "Значение производной функции в точке #{x} равно #{fuction}"
    fuction=0.0

    for number in 0..array.size
        if(array[number].to_i==0) then 
            for delete in number..array.size
                array[delete]=array[delete+1]
            end
        end
    end
    puts "Уплощённый массив :#{array.compact}"
end

def solve_with_iterators(array)
    puts "Для итератора :"
    count=0
  array.each_with_index do |number,index|
    if(index==array.size) then  
        break
    end
   if(get_znak(array[index])!=get_znak(array[index+1])) then 
     count=count+1
     puts "Индексы смены знака #{index} и #{index+1}"
   end
  end
  puts "Количество смены знака #{count}"

  array.each_with_index do |number,index|
    index1=index
    while(index1.modulo(2)==0) 
        index1=index1.to_f/2
        if(index1==0)then  break
        end
        if(index1==1)then  puts number end
    end
  end

  puts "Введите точку в которой необходимо посчитать функцию x: "
  print ">>"
  x=gets.strip

  fuction=0.0
  array.each_with_index do |number,index|
    fuction=fuction+number.to_f*x.to_f**index.to_f
  end
  puts "Значение функции в точке #{x} равно #{fuction}"

  fuction=0.0
 array.each_with_index do |number,index|
    next if index==0
      fuction=fuction+number.to_f*index.to_f*x.to_f**(index.to_f-1)
  end
  puts "Значение производной функции в точке #{x} равно #{fuction}"
  fuction=0.0


  array.delete_if {|number| number==0 }
  puts "Уплощённый массив :#{array}"
end

if __FILE__ == $0
  main
end