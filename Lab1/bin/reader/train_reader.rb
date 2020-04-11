require 'csv'

# require_relative 'train_information.rb'
# require_relative 'train.rb'
# read csv file
class TrainRead
    def initialize()
        @trainStation=[]
        @trainInformation=[]
    end
    def addSt(train)
        @trainStation.push(train)
    end
    def addIn(train)
        @trainInformation.push(train)
    end
    def getTrainSt
        @trainStation
    end
    def getTrainIn
        @trainInformation
    end
    def read_in_train1(filenames)
        train = TrainRead.new
        CSV.foreach(filenames, headers: true) do |row|
        @trainStation.push(TrainStation.new(
        row['CODE'], row['TITLE']
        ))
        end
    end
    def read_in_train2(filenames)
        train = TrainRead.new
        CSV.foreach(filenames, headers: true) do |row|
        @trainInformation.push(TrainInformation.new(
        row['TRAINID'], row['NUMBER'], row['STATION_CODE'], row['ARRIVAL_TIME'],
        row['STOP_DURATION'], row['DISTANCE']
        ))
        end
    end
end