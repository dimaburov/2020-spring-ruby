class TrainInformation
    def initialize(training, number, station_code,arrival_time, stop_duration, distance)
        @training=training
        @number=number
        @station_code=station_code
        @arrival_time=arrival_time
        @stop_duration=stop_duration
        @distance=distance
    end
    attr_reader :training
    attr_reader :number
    attr_reader :station_code
    attr_reader :arrival_time
    attr_reader :stop_duration
    attr_reader :distance
    def terminalIn(array)
        maxnumber=0
        array.getTrainIn.each_with_index do |number, index|
           if  number.training==@training then maxnumber=number.number
           end
        end
        array.getTrainIn.each_with_index do |number, index|
            if  maxnumber==number.number then return index
            end
         end
    end
    def station(array)
        count=0
        array.getTrainIn.each_with_index do |number, index|
            if  ((number.training==@training)&&(stop_duration!=0)) then count=count+1
            end
         end
         return count 
    end
    def first_station(array)
        array.getTrainIn.each_with_index do |number, index|
            if  ((number.training==@training)&&(number.number.to_i==1)) then return index
            end
         end
    end
end