# frozen_string_literal: true

require 'roda'

require_relative 'lib/diary.rb'
require_relative 'lib/diary_list.rb'
require_relative 'lib/input_validators.rb'
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
                                 Diary.new('2018-03-07', 'Кафка', 'Процесс'),
                                 Diary.new('2019-05-10', 'Бёрджесс', 'Заводной апельсин'),
                                 Diary.new('2020-04-05', 'Кен Кизи', 'Над кукушкиным гнездом'),
                                 Diary.new('2018-03-06', 'Бредбери', 'Вино из одуванчиков'),
                                 Diary.new('2018-04-06', 'Ремарк', 'Три товарища')
                               ])
  route do |r|
    r.public if opts[:serve_static]
    r.root { r.redirect '/diary' }
    r.on 'diary' do
      r.is do
        opts[:books].sort_by_data
        @all_books = opts[:books].all_books
        view('index')
      end
      r.on 'new' do
        r.get do
          view('new_book')
        end
        r.post do
          @params = InputValidators.check_side_lengths(r.params['author'],
                                                       r.params['title'], r.params['date'])
          if @params[:error].empty?
            opts[:books].add_books(Diary.new(@params[:date], @params[:author], @params[:title]))
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
          @month = opts[:books].array_count(r.params['year']) if @params[:error].empty?
          view('statistics')
        end
      end
    end
  end
end
