# frozen_string_literal: true

require './lib/pieces/chess_piece'

# Pawn class
class Pawn < ChessPiece
  def initialize(team, icon, pos)
    super(team, icon, pos)
  end
end
