# frozen_string_literal: true

require './lib/pieces/chess_piece'

# King class
class King < ChessPiece
  def initialize(team, icon, pos)
    super(team, icon, pos)
  end
end
