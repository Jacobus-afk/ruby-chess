# frozen_string_literal: true

require './lib/pieces/chess_piece'

# Rook class
class Rook < ChessPiece
  def initialize(team, icon, pos)
    super(team, icon, pos)
  end
end
