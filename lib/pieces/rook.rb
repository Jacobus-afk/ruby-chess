# frozen_string_literal: true

require './lib/pieces/chess_piece'

ROOK_VECTORS = [[1, 0], [-1, 0], [0, 1], [0, -1]].freeze

# Rook class
class Rook < ChessPiece
  def initialize(team, pos)
    super(team, '♖', pos)
  end

  def generate_possible_moves
    super(ROOK_VECTORS)
  end
end
