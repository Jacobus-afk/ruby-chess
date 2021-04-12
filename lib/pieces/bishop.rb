# frozen_string_literal: true

require './lib/pieces/chess_piece'

BISHOP_VECTORS = [[-1, -1], [-1, 1], [1, 1], [1, -1]].freeze

# Bishop class
class Bishop < ChessPiece
  def initialize(team, pos)
    super(team, '♗', pos)
  end

  def generate_possible_moves
    super(BISHOP_VECTORS)
  end
end

if __FILE__ == $PROGRAM_NAME
  piece = Bishop.new(WHITE_PIECE, 'c8')
  piece.move('f5')
  puts
end
