require_relative "read_student.rb"
require_relative "student_list.rb"
require_relative "student.rb"

require 'tty-prompt'

class Menu
    def initialize
        @prompt=TTY::Prompt.new
        @student_list=ReadStudent.read_match
    end
    Main_Menu_Choices =[
        {name: 'Находит и отображать список двоечников',value: :scale},
        {name: 'Вычислять статистику тестирования', value: :test},
        {name: 'Пересчитать оценки по другой шкале', value: :losers},
        {name: 'Проверить на возможное списывание', value: :copying},
        {name: 'Найти три самых сложных вопроса', value: :hard},
        {name: 'завершить работу', value: :exit}
    ]
    def menu_creater
        loop do
            action=@prompt.select('Выберете действие', Main_Menu_Choices)
            break if action==:exit
            case action
            when :losers
                @student_list.iterator_losers do |std|
                    puts std
                end
            when :test
               puts @student_list.test_bloc
            when :scale
                puts "Введите новую шкалу для выставления оценок"
                point_3=gets
                point_4=gets
                point_5=gets
                puts @student_list.new_table_score(point_3, point_4, point_5)
            end
        end
    end
end