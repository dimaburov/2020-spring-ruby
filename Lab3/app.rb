# frozen_string_literal: true

require 'roda'

require_relative 'lib/diary.rb'
require_relative 'lib/diary_list.rb'
# The core class of the web application for managing tests
class App < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :render
  configure :development do
    plugin :public
    opts[:serve_static] = true
  end
  opts[:index] = DiaryList.new([ 
                                 Diary.new('2018-03-07', 'AAA', 'BBB'),
                                 Diary.new('2019-05-10', 'Бёрджесс', 'Заводной апельсин'),
                                 Diary.new('2020-04-05', 'Кен Кизи', 'Над кукушкиным гнездом'),
                                 Diary.new('2018-03-06', 'Бредбери', 'Вино из одуванчиков'),
                                 Diary.new('2018-04-06', 'bbbb', 'aaa')
                               ])
  route do |r|
    r.public if opts[:serve_static]
    r.root do
      r.redirect '/diary'
    end
    r.on 'diary' do
      r.is do
        # @params = InputValidators.check_min_and_max(r.params['min'], r.params['max'])
        # pp @params[:error]
        opts[:index].sort_by_data
        @all_books = opts[:index].all_books
        view('index')
      end
    end
  end
end
