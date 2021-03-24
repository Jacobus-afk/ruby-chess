# frozen_string_literal: true

require './lib/pieces/chess_piece'

# Pawn class
class Pawn < ChessPiece
  def initialize(team, pos)
    super(team, '♙', pos)
  end

  def find_possible_moves
    
  end
end
