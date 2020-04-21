require_relative "matchs.rb"
require_relative "match_list.rb"
require_relative "read_match.rb"

require 'tty-prompt'
# write menu
class Menu 
    def initialize
        @match_list=MatchList.new
    end
    def create_menu
      @match_list.iterator_sort_by_team2 do |sort|
        puts sort
      end
      puts "Сортировка по point"
      @match_list.iterator_sort_by_point2 do |sort|
        puts sort
      end
      # @match_list.iterator_sort_by_team do |sort|
      #   puts sort
      # end
      # @match_list.iteratot_sort_by_point do |sort|
      #   puts sort
      # end
    end
end