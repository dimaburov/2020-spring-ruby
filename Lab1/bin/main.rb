require 'tty-prompt'

require_relative 'train/train.rb'
require_relative 'reader/train_reader.rb'
require_relative 'train/train_information.rb'
def main()
    prompt = TTY::Prompt.new
    array1=  TrainRead.new()
    array2=  TrainRead.new()
    array1.read_in_train1('../data/stations.csv')
    array2.read_in_train2('../data/stops.csv')
  word = prompt.select('select an action') do |menu|
    menu.enum '.'
    menu.choice 'Display the train schedule', 1
    menu.choice 'Display a list of trains sorted by the number of actual stops', 2
    menu.choice 'Shut down the app', 3
  end
  case word
  when 1 
    number = prompt.select('select an action') do |menu|
        menu.enum '.'
        count=0
        number_train=0
      array2.getTrainIn.each_with_index do |num, index|
        if(number_train!=num.training) then
          number_train=num.training
          ind =array2.getTrainIn[index].terminalIn(array2)
          value=array1.getTrainSt[index].terminalSt(array1, array2.getTrainIn[ind].station_code)
          sad =array2.getTrainIn[index].first_station(array2)
          value2=array1.getTrainSt[index].terminalSt(array1, array2.getTrainIn[sad].station_code )
          data1 = array1.getTrainSt[value2].title.encode('UTF-8').strip
          data2 = array1.getTrainSt[value].title.encode('UTF-8').strip
          menu.choice "#{array2.getTrainIn[index].training} : #{data1} (#{array2.getTrainIn[index].arrival_time}) #{data2}(#{array2.getTrainIn[ind].arrival_time}) ", count
          count=count+1
        end
      end
    end
    puts "Расписание поезде номер #{array2.getTrainIn[number].training}"
    array2.getTrainIn.each_with_index do |data, index|
      if(array2.getTrainIn[number].training== array2.getTrainIn[index].training) then
      title= array1.getTrainSt[index].terminalSt(array1, array2.getTrainIn[index].station_code)
      puts "#{array2.getTrainIn[index].number}: #{ array2.getTrainIn[index].arrival_time}  #{array1.getTrainSt[title].title}"
      end
    end
  when 2
  array_station=[]
  dat=0
  array2.getTrainIn.each_with_index do |data, index|
    if(data.station(array2)!=dat) then
    array_station[index]=data.station(array2)
    dat=array_station[index]
    end
  end
  array_station= array_station.compact.sort!
  array_station.compact.each_with_index do |num, index|
    array2.getTrainIn.each_with_index do |data, ind|
      if(data.station(array2)==num) then
        inds =array2.getTrainIn[ind].terminalIn(array2)
        value=array1.getTrainSt[ind].terminalSt(array1, array2.getTrainIn[inds].station_code)
        sad =array2.getTrainIn[ind].first_station(array2)
        value2=array1.getTrainSt[ind].terminalSt(array1, array2.getTrainIn[sad].station_code )
        data1 = array1.getTrainSt[value2].title.encode('UTF-8').strip
        data2 = array1.getTrainSt[value].title.encode('UTF-8').strip
        puts "Остановок #{num}: #{array2.getTrainIn[ind].training}: #{data1} (#{array2.getTrainIn[ind].arrival_time}) #{data2}(#{array2.getTrainIn[inds].arrival_time}) "
        break
      end
    end
  end
  when 3
    puts "Вы выбрали выход из программы!"
    return

  end

  

end

main if __FILE__ == $PROGRAM_NAME
