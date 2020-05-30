# frozen_string_literal: true

require_relative 'landing'

# The class that contains all our landing
class LandingList

    def initialize(landing = [])
        @landings = landing.map do |land|
          [land.id, land]
        end.to_h
    end

    def all_landings
        @landings.values
    end
    
    def lading_by_id(id)
    @landings[id]
    end

    def add_landing(parameters)
         if @landings==nil then 
            landing_id= 1
         else 
            landing_id = @landings.keys.max + 1
         end
        @landings[landing_id] = Landing.new(
          id: landing_id,
          type: parameters[:type],
          name: parameters[:name],
          scope: parameters[:scope],
          unit: parameters[:unit],
          description: parameters[:description],
          landing_date: parameters[:landing_date]
        )
        landing_id
    end

    def update_landing(id, parameters)
        landing = @landings[id]
        landing.type = parameters[:type]
        landing.name = parameters[:name]
        landing.scope = parameters[:scope]
        landing.unit = parameters[:unit]
        landing.description = parameters[:description]
        landing.landing_date = parameters[:landing_date]
    end

    def delete_landing(id)
        @landings.delete(id)
    end

    def landings_sort_by_date
        @landings = @landings.sort do |a, b|
            if (b[1].landing_date.year.to_i <=> a[1].landing_date.year.to_i).zero?
              if (b[1].landing_date.mon.to_i <=> a[1].landing_date.mon.to_i).zero?
                b[1].landing_date.mday.to_i <=> a[1].landing_date.mday.to_i
              else b[1].landing_date.mon.to_i <=> a[1].landing_date.mon.to_i
              end
            else b[1].landing_date.year.to_i <=> a[1].landing_date.year.to_i
            end
         end.to_h
     end
end