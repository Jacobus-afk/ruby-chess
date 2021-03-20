# frozen_string_literal: true

require './lib/colors'
require './lib/pieces/chess_piece'
# chess board template
module BoardTemplate
  # BLACK_TILE = "\e[100m   \e[0m"
  # WHITE_TILE = "\e[107m   \e[0m"

  COLOR_TILES_METHOD = %i[white_bg black_bg].freeze
end

# board class
class Board
  include BoardTemplate

  def initialize
    height = 8
    width = 8
    @board = Array.new(height) { Array.new(width) }
    @board_display = Array.new(height) { Array.new(width) { '   '.dup } }
  end

  def draw_board
    _add_pieces_to_board
    _fill_in_tiles
  end

  def start_game
    @board[0][0] = ChessPiece.new('♜', 'a8')
    @board[0][1] = ChessPiece.new('♞', 'b8')
    @board[0][2] = ChessPiece.new('♝', 'c8')
    @board[0][3] = ChessPiece.new('♛', 'd8')
    @board[0][4] = ChessPiece.new('♚', 'e8')
    @board[0][5] = ChessPiece.new('♝', 'f8')
    @board[0][6] = ChessPiece.new('♞', 'g8')
    @board[0][7] = ChessPiece.new('♜', 'h8')
    @board[1][0] = ChessPiece.new('♟︎', 'a7')
    @board[1][1] = ChessPiece.new('♟︎', 'b7')
    @board[1][2] = ChessPiece.new('♟︎', 'c7')
    @board[1][3] = ChessPiece.new('♟︎', 'd7')
    @board[1][4] = ChessPiece.new('♟︎', 'e7')
    @board[1][5] = ChessPiece.new('♟︎', 'f7')
    @board[1][6] = ChessPiece.new('♟︎', 'g7')
    @board[1][7] = ChessPiece.new('♟︎', 'h7')
    @board[7][0] = ChessPiece.new('♖', 'a1')
    @board[7][1] = ChessPiece.new('♘', 'b1')
    @board[7][2] = ChessPiece.new('♗', 'c1')
    @board[7][3] = ChessPiece.new('♕', 'd1')
    @board[7][4] = ChessPiece.new('♔', 'e1')
    @board[7][5] = ChessPiece.new('♗', 'f1')
    @board[7][6] = ChessPiece.new('♘', 'g1')
    @board[7][7] = ChessPiece.new('♖', 'h1')
    @board[6][0] = ChessPiece.new('♙', 'a2')
    @board[6][1] = ChessPiece.new('♙', 'b2')
    @board[6][2] = ChessPiece.new('♙', 'c2')
    @board[6][3] = ChessPiece.new('♙', 'd2')
    @board[6][4] = ChessPiece.new('♙', 'e2')
    @board[6][5] = ChessPiece.new('♙', 'f2')
    @board[6][6] = ChessPiece.new('♙', 'g2')
    @board[6][7] = ChessPiece.new('♙', 'h2')
    draw_board
  end

  private

  def _add_pieces_to_board
    (0..@board.length - 1).each do |y|
      (0..@board[y].length - 1).each do |x|
        @board_display[y][x][1] = @board[y][x] ? @board[y][x].unicode : ' '
      end
    end
  end

  def _fill_in_tiles
    tmp_arr = Array.new(@board_display.length) { '' }

    (0..@board_display.length - 1).each do |y|
      (0..@board_display[y].length - 1).each do |x|
        tmp_arr[y] += _add_tile_to_string(y, x)
      end
    end
    tmp_arr
  end

  def _add_tile_to_string(yvar, xvar)
    color = (xvar % 2 + yvar % 2) % 2
    @board_display[yvar][xvar].send(COLOR_TILES_METHOD[color])
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  puts board.draw_board
  puts board.start_game
end
