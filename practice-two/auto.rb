class Auto
    def initialize(brand,model,manifacture_year,gasoline_consumption)
        @brand=brand
        @model=model
        @manifacture_year=manifacture_year
        @gasoline_consumption=gasoline_consumption
    end
    def brand 
        @brand
    end
    def model
        @model
    end
    def manifacture_year
        @manifacture_year
    end
    def gasoline_consumption
        @gasoline_consumption
    end
    def to_s
        return "\n\t\tbrand :  #{brand}
                model :  #{model}
                year :  #{manifacture_year}
                consumption :  #{gasoline_consumption}"
    end
end