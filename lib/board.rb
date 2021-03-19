# frozen_string_literal: true

require './lib/colors.rb'

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
    _fill_in_tiles
  end

  def start_game
    @board_display[0][0][1] = '♜'
    @board_display[0][1][1] = '♞'
    @board_display[0][2][1] = '♝'
    @board_display[0][3][1] = '♛'
    @board_display[0][4][1] = '♚'
    @board_display[0][5][1] = '♝'
    @board_display[0][6][1] = '♞'
    @board_display[0][7][1] = '♜'

    @board_display[1][0][1] = '♟︎'
    @board_display[1][1][1] = '♟︎'
    @board_display[1][2][1] = '♟︎'
    @board_display[1][3][1] = '♟︎'
    @board_display[1][4][1] = '♟︎'
    @board_display[1][5][1] = '♟︎'
    @board_display[1][6][1] = '♟︎'
    @board_display[1][7][1] = '♟︎'

    @board_display[6][0][1] = '♖'
    @board_display[6][1][1] = '♘'
    @board_display[6][2][1] = '♗'
    @board_display[6][3][1] = '♕'
    @board_display[6][4][1] = '♔'
    @board_display[6][5][1] = '♗'
    @board_display[6][6][1] = '♘'
    @board_display[6][7][1] = '♖'

    @board_display[7][0][1] = '♙'
    @board_display[7][1][1] = '♙'
    @board_display[7][2][1] = '♙'
    @board_display[7][3][1] = '♙'
    @board_display[7][4][1] = '♙'
    @board_display[7][5][1] = '♙'
    @board_display[7][6][1] = '♙'
    @board_display[7][7][1] = '♙'
    draw_board
  end

  private

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
