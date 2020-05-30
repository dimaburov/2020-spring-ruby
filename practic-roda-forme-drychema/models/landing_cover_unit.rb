# frozen_string_literal: true

# The list of possible landing cover types
module LandingCoverUnit
    LANDING = 'Посадка'
    SOILPREPARATION = "Подготовка почвы"
    HARVEST= "Сбор урожая" 
    CUTTING = "Стрижка травы"
    CLEANING = 'Уборка'
    def self.all_types
      [
        LANDING, SOILPREPARATION, HARVEST, CUTTING, CLEANING
      ]
    end
  end