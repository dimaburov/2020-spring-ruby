# frozen_string_literal: true

require 'roda'

require_relative 'models/diary.rb'
require_relative 'models/diary_list.rb'
require_relative 'models/input_validators.rb'
# The core class of the web application for managing tests
class App < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :render
  configure :development do
    plugin :public
    opts[:serve_static] = true
  end
  opts[:books] = DiaryList.new([
                                 Diary.new('2018-03-07', 'Кафка', 'Процесс', '5', 'Электронная книга', '12', 'dasd'),
                                 Diary.new('2019-05-10', 'Бёрджесс', 'Заводной апельсин', '3', 'Аудио книга', '32', ' '),
                                 Diary.new('2020-04-05', 'Кен Кизи', 'Над кукушкиным гнездом', '4', 'Бумажная книга', '12', ' '),
                                 Diary.new('2018-03-06', 'Бредбери', 'Вино из одуванчиков', '2', 'Электронная книга', '2', 'dsad'),
                                 Diary.new('2018-04-06', 'Ремарк', 'Три товарища', '5', 'Аудио книга', '11', 'dsad')
                               ])
  route do |r|
    r.public if opts[:serve_static]
    r.root do
      r.redirect '/diary'
    end
    r.on 'diary' do
      r.is do
        opts[:books].sort_by_data
        @params = InputValidators.check_side_format(r.params['formats'])
        @filter_books = if @params[:error]
                          opts[:books].filte_format(@params[:formats])
                        else
                          opts[:books].all_books
                         end
        view('index')
      end
      r.on 'new' do
        r.get do
          view('new_book')
        end
        r.post do
          @params = InputValidators.check_side_lengths(r.params['author'],
                                                       r.params['title'], r.params['date'],
                                                       r.params['formats'], r.params['size'],
                                                       r.params['point'], r.params['txt'])
          if @params[:error].empty?
            opts[:books].add_books(Diary.new(@params[:date], @params[:author],
                                             @params[:title], @params[:point],
                                             @params[:formats], @params[:size], @params[:txt]))
            r.redirect '/diary'
          else
            view('new_book')
          end
        end
      end
      r.on 'statistics' do
        r.get do
          opts[:books].sort_by_data
          @book_year = opts[:books].array_year
          @params = InputValidators.check_side_year(r.params['year'], @book_year)
          @month = if @params[:error].empty?
                     opts[:books].array_count(r.params['year'])
                   else opts[:books].hash_month
                   end
          view('statistics')
        end
      end
    end
  end
end
