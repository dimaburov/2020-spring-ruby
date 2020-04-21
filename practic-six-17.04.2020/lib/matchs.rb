# rezult of the match
class Match
    def initialize(team_one, point_one, team_two, point_two)
        @team_one=team_one
        @team_two=team_two
        @point_one=Integer(point_one)
        @point_two=Integer(point_two)
    end
    attr_reader :team_one
    attr_reader :team_two
    attr_reader :point_one
    attr_reader :point_two

end