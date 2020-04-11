
# initialize a train
class TrainStation
    def initialize(code, title)
        @code=code
        @title=title
    end
    attr_reader :code
    attr_reader :title

    def terminalSt(array, stcode)
        array.getTrainSt.each_with_index do |number, index|
           if  number.code==stcode then return index
           end
        end
    end
end