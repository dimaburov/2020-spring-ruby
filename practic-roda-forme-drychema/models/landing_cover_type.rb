# frozen_string_literal: true

# The list of possible landing cover types
module LandingCoverType
    ROW = 'Ряд'
    BED = 'Грядка'
    SQUAREMATER= "Квадратный метр" 
    PIECE = 'Штука'
    def self.all_types
      [
        ROW, BED, SQUAREMATER, PIECE
      ]
    end
  end