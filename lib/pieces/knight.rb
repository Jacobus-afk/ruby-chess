# frozen_string_literal: true

require './lib/pieces/chess_piece'

# Knight class
class Knight < ChessPiece
  def initialize(team, pos)
    super(team, '♘', pos)
  end
end
