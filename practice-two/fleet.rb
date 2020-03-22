class Fleet
    def initialize()
        @cars=[]
    end
    def add(car)
        @cars.push=car
        puts @cars
    end
    def load_from_file(file_name)
        require 'json'
     json_data = File.read(file_name)
     ruby_objects = JSON.parse(json_data)
     while(ruby_objects['mark']!=nil) do
        add(Auto.new(ruby_objects['mark'],ruby_objects['model'],ruby_objects['year'],ruby_objects['consumption']))
     end
    end
    def average_consumption ()
        @cars.each do |kol|
            allsum=allsum+@cars[kol].gasoline_consumption
        end
       return average=allsum/@cars.size
    end

    def number_by_brand (brand)
        count=0
        @cars.each do |kol|
            if(@cars[kol].brand==brand) then count=count+1
             end
        end
        return count
    end

    def number_by_model(model)
        count=0
        @cars.each do |kol|
            if(@cars[kol].model==model) then count=count+1
             end
        end
        return count
    end
    def consumption_by_brand(brend)
        count=0
        allsum.to_f
        @cars.each do |kol|
            if(@cars[kol].brand==brand) then 
                allsum=@cars[kol].gasoline_consumption+allsum
                count=count+1
            end
         return average=allsum/count
        end
    end
end
