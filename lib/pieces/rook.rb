# frozen_string_literal: true

require './lib/pieces/chess_piece'

# Rook class
class Rook < ChessPiece
  def initialize(team, pos)
    super(team, '♖', pos)
  end
end
