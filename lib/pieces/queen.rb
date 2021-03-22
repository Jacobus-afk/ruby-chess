# frozen_string_literal: true

require './lib/pieces/chess_piece'

# Queen class
class Queen < ChessPiece
  def initialize(team, icon, pos)
    super(team, icon, pos)
  end
end
