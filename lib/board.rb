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
    @board[0][0] = ChessPiece.new(1, '♖', 'a8')
    @board[0][1] = ChessPiece.new(1, '♘', 'b8')
    @board[0][2] = ChessPiece.new(1, '♗', 'c8')
    @board[0][3] = ChessPiece.new(1, '♕', 'd8')
    @board[0][4] = ChessPiece.new(1, '♔', 'e8')
    @board[0][5] = ChessPiece.new(1, '♗', 'f8')
    @board[0][6] = ChessPiece.new(1, '♘', 'g8')
    @board[0][7] = ChessPiece.new(1, '♖', 'h8')
    @board[1][0] = ChessPiece.new(1, '♙', 'a7')
    @board[1][1] = ChessPiece.new(1, '♙', 'b7')
    @board[1][2] = ChessPiece.new(1, '♙', 'c7')
    @board[1][3] = ChessPiece.new(1, '♙', 'd7')
    @board[1][4] = ChessPiece.new(1, '♙', 'e7')
    @board[1][5] = ChessPiece.new(1, '♙', 'f7')
    @board[1][6] = ChessPiece.new(1, '♙', 'g7')
    @board[1][7] = ChessPiece.new(1, '♙', 'h7')
    @board[7][0] = ChessPiece.new(0, '♖', 'a1')
    @board[7][1] = ChessPiece.new(0, '♘', 'b1')
    @board[7][2] = ChessPiece.new(0, '♗', 'c1')
    @board[7][3] = ChessPiece.new(0, '♕', 'd1')
    @board[7][4] = ChessPiece.new(0, '♔', 'e1')
    @board[7][5] = ChessPiece.new(0, '♗', 'f1')
    @board[7][6] = ChessPiece.new(0, '♘', 'g1')
    @board[7][7] = ChessPiece.new(0, '♖', 'h1')
    @board[6][0] = ChessPiece.new(0, '♙', 'a2')
    @board[6][1] = ChessPiece.new(0, '♙', 'b2')
    @board[6][2] = ChessPiece.new(0, '♙', 'c2')
    @board[6][3] = ChessPiece.new(0, '♙', 'd2')
    @board[6][4] = ChessPiece.new(0, '♙', 'e2')
    @board[6][5] = ChessPiece.new(0, '♙', 'f2')
    @board[6][6] = ChessPiece.new(0, '♙', 'g2')
    @board[6][7] = ChessPiece.new(0, '♙', 'h2')
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
  test = board.start_game
  puts
end
