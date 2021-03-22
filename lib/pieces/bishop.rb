# frozen_string_literal: true

require './lib/pieces/chess_piece'

# Bishop class
class Bishop < ChessPiece
  def initialize(team, icon, pos)
    super(team, icon, pos)
  end
end
