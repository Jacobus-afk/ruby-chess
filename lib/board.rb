# frozen_string_literal: true

require './lib/colors.rb'

# chess board template
module BoardTemplate
  # BLACK_TILE = "\e[100m   \e[0m"
  # WHITE_TILE = "\e[107m   \e[0m"

  COLOR_TILES_METHOD = %i[white_bg black_bg].freeze

  # def create_board
  #   [WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE,
  #    BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE,
  #    WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE,
  #    BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE,
  #    WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE,
  #    BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE,
  #    WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE,
  #    BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE + BLACK_TILE + WHITE_TILE]
  # end
end

# board class
class Board
  include BoardTemplate

  def initialize
    height = 8
    width = 8
    @board = Array.new(height) { Array.new(width) }
    @board_display = Array.new(height) { Array.new(width) { '   ' }}
  end

  def draw_board
    _fill_in_tiles
  end

  # def d_board
  #   _fill_in_tiles
  # end

  private

  def _fill_in_tiles
    # color = 0
    tmp_arr = Array.new(@board_display.length) { '' }

    (0..@board_display.length - 1).each do |y|
      (0..@board_display[y].length - 1).each do |x|
        # color %= 2
        # tmp_arr[y] += @board_display[y][x].send(COLOR_TILES_METHOD[color])
        # print @board_display[y][x].send(COLOR_TILES_METHOD[color])
        # color += 1
        tmp_arr[y] += _add_tile_to_string(y, x)
      end
      # color += 1
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
  test = board.draw_board
  puts test
end
