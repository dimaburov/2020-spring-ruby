class Fleet
    def initialize()
        @cars=[]
    end
    def add(Car)
        @cars.push=Car
    end
    def load_from_file(file_name)
        require 'json'
     json_data = File.read(file_name)
     ruby_objects = JSON.parse(json_data)
     pp  ruby_objects
    end
end
