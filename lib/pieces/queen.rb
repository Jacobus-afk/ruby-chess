# frozen_string_literal: true

require './lib/pieces/chess_piece'

QUEEN_VECTORS = [[-1, -1], [-1, 1], [1, 1], [1, -1], [0, 1], [1, 0], [0, -1], [-1, 0]].freeze

# Queen class
class Queen < ChessPiece
  def initialize(team, pos)
    super(team, '♕', pos)
  end

  def generate_possible_moves
    super(QUEEN_VECTORS)
  end
end
