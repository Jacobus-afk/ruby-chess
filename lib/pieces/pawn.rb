# frozen_string_literal: true

require './lib/pieces/chess_piece'

# Pawn class
class Pawn < ChessPiece
  def initialize(team, pos)
    super(team, '♙', pos)
    @promoted = false
  end

  def promoted?
    @promoted
  end

  def move(pos)
    super(pos)
    _check_for_promotion
  end

  def find_possible_moves
    possible_moves = _fill_moves_arr(coordinate[1], coordinate[0])
    # x = coordinate[1]
    # y = coordinate[0]
    # possible_moves.push([y + 1, x - 1])
    # possible_moves.push([y + 1, x])
    # possible_moves.push([y + 1, x + 1])
    # possible_moves.push([y + 2, x]) if first_move?

    possible_moves.filter_map do |move|
      find_position(move)
    end
  end

  private

  def _check_for_promotion
    @promoted = true if @coordinate[0].zero? || @coordinate[0] == 7
  end

  def _move_one(val)
    team == BLACK_PIECE ? val + 1 : val - 1
  end

  def _fill_moves_arr(xvar, yvar)
    moves_arr = []
    y = _move_one(yvar)
    moves_arr.push([y, xvar - 1])
    moves_arr.push([y, xvar])
    moves_arr.push([y, xvar + 1])
    moves_arr.push([_move_one(y), xvar]) if first_move?
    moves_arr
  end
end

if __FILE__ == $PROGRAM_NAME
  piece = Pawn.new(BLACK_PIECE, 'c7')
  piece.move('c6')
  test = piece.find_possible_moves
  puts test
end
