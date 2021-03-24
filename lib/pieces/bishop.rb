# frozen_string_literal: true

require './lib/pieces/chess_piece'

# Bishop class
class Bishop < ChessPiece
  def initialize(team, pos)
    super(team, '♗', pos)
  end
end
