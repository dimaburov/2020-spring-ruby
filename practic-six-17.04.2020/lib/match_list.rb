require_relative "read_match.rb"
require_relative "matchs.rb"

require "csv"
class MatchList
    def initialize
        @matchs=[]
    self.read_match
        @team=get_all_team
    end
    
    def add_match(match)
        @matchs.push(match)
    end
    def read_match
    file = File.expand_path('../data/match.csv', __dir__)
    CSV.foreach(file, headers: true) do |row|
        @matchs.push(Match.new(
            row["team_one"], row["points_one"],
            row["team_two"], row["points_two"]
        ))
    end
  end
    def get_all_team
        teams=Hash.new(0)
        @matchs.each do |match|
            teams[match.team_one]+=match.point_one
            teams[match.team_two]+=match.point_two
        end
        teams.to_a #to_a возвращает массив
    end
    def iterator_sort_by_team2
        arr=@team.map{|n| n[0] }.sort #выделяем все названия команд и сортируем их
        return arr.enum_for(:each) unless block_given?
        #если нет блока возвращаем нумератор, если есть блок то выполняем его для каждого элемента
        arr.each do |array|
            yield array
        end
    end
    def iterator_sort_by_point2
        arr=@team.sort{|a,b| a[1]<=>b[1]}.map{|n| n[0]}
        return arr.enum_for(:each) unless block_given?

        arr.each do |array|
            yield array
        end
    end 
    def matches
       return @matchs.enum_for(:each) unless block_given?
       
       @matchs.each do |match|
        yield match
        end
    end
    def remove_if
        return "Пожалуйста,ассациируйте блок" unless block_given?
        @matchs.delete_if do |del|
            yield del
        end
    end




    def iterator_sort_by_team
        arr=( @matchs.map{|t| t.team_one} + @matchs.map{|t| t.team_two}).sort

        return arr.enum_for(:each) unless block_given? #возвращаем итератор если блок не найден

        arr.each do |t|
            yield t
        end
    end
    def sort_point_team
        team=[]
        lambda do |n| 
            flag=0
            team.push(n) if team.empty?
            team.each do |teams|
                if teams==n then flag +=1
                end
            end
            team.push(n) if flag==0
            return team
        end

    end
    def iteratot_sort_by_point
        arr=(@matchs.map{|t| t.point_one} + @matchs.map{|t| t.point_two}).sort
        sorting=sort_point_team()
        arr.each do |array|
            @matchs.each do |match|
                if array==match.point_one then  sorting.call(match.team_one)
                end
                if array==match.point_two then  sorting.call(match.team_two)
                end
            end
        end
        team=[]
        team=sorting.call(@matchs[0].team_one)
        return team.enum_for(:each) unless block_given? #возвращаем итератор если блок не найден
        team.each do |t|
            yield t
        end
    end

end