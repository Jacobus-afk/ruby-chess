# frozen_string_literal: true

require './lib/pieces/chess_piece'

# King class
class King < ChessPiece
  def initialize(team, pos)
    super(team, '♔', pos)
    @castling = false
  end

  def castling?
    @castling
  end
end
