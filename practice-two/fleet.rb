class Fleet
    def initialize()
        @cars=[]
    end
    def add(car)
        @cars.push(car)
    end
    def load_from_file(file_name)
        require 'json'
      json_data = File.read(file_name)
     ruby_objects = JSON.parse(json_data)
     kol=0
     while(ruby_objects.size!=kol) do
        add(Auto.new(ruby_objects[kol]['mark'],ruby_objects[kol]['model'],ruby_objects[kol]['year'],ruby_objects[kol]['consumption']))
        kol=kol+1
     end
    
    end
    def average_consumption ()
        kol=0
        sumall=0.0
        while(@cars.size!=kol) do
            sumall=@cars[kol].gasoline_consumption.to_f+sumall
            kol=kol+1
        end
       return average=sumall/@cars.size
    end

    def number_by_brand (brand)
        count=0
        kol=0
        while(@cars.size!=kol) do
            if(@cars[kol].brand==brand) then count=count+1
             end
             kol=kol+1
        end
        return count
    end

    def number_by_model(model)
        count=0
        kol=0
        while(@cars.size!=kol) do
            if(@cars[kol].model==model) then count=count+1
             end
             kol=kol+1
        end
        return count
    end
    def consumption_by_brand(brand)
        count=0
        allsum=0.0
        kol=0
        while(@cars.size!=kol) do
            if(@cars[kol].brand==brand) then 
                allsum=@cars[kol].gasoline_consumption.to_f+allsum
                count=count+1
            end
            kol=kol+1
        end
        return average=allsum/count
    end
end
