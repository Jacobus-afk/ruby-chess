# frozen_string_literal: true

require './lib/pieces/chess_piece'

# Knight class
class Knight < ChessPiece
  def initialize(team, icon, pos)
    super(team, icon, pos)
  end
end
