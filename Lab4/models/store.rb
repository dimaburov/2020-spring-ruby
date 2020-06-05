# frozen_string_literal: true

require 'psych'
require_relative 'train_list'
require_relative 'train'

# Storage for all of our data
class Store
  attr_reader :train_list

  DATA_STORE = File.expand_path('../db/data.yaml', __dir__)

  def initialize
    @train_list = TrainList.new
    read_data
    at_exit { write_data }
  end

  def read_data
    return unless File.exist?(DATA_STORE)

    yaml_data = File.read(DATA_STORE)
    raw_data = Psych.load(yaml_data, symbolize_names: true)
    raw_data[:train_list].each do |raw_train|
      @train_list.add_real_trains(Train.new(**raw_train))
    end
  end

  def write_data
    raw_train = @train_list.all_real_trains.map(&:to_h)
    yaml_data = Psych.dump({
                             train_list: raw_train
                           })
    File.write(DATA_STORE, yaml_data)
  end
end
