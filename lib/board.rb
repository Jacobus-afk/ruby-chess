# frozen_string_literal: true

require './lib/colors'
require './lib/pieces/chess_piece'

# chess board template
module BoardTemplate
  COLOR_TILES_METHOD = %i[white_bg black_bg].freeze
end

# board class
class Board
  include BoardTemplate

  def initialize
    height = 8
    width = 8
    @pieces = []
    @board_display = Array.new(height) { Array.new(width) { '   '.dup } }
  end

  def draw_board
    _add_pieces_to_board_display
    _fill_in_tiles
  end

  def start_game
    _init_board_pieces
    draw_board
  end

  private

  def _add_piece(team, icon, pos)
    piece = ChessPiece.new(team, icon, pos)
    @pieces.push(piece)
  end

  def _add_pieces(icon)
    PIECE_DATA[icon][WHITE_PIECE][:start_pos].each { |pos| _add_piece(WHITE_PIECE, icon, pos) }
    PIECE_DATA[icon][BLACK_PIECE][:start_pos].each { |pos| _add_piece(BLACK_PIECE, icon, pos) }
  end

  def _init_board_pieces
    _add_pawns
    _add_rooks
    _add_knights
    _add_bishops
    _add_queens
    _add_kings
  end

  def _add_pawns
    _add_pieces('♙')
  end

  def _add_rooks
    _add_pieces('♖')
  end

  def _add_knights
    _add_pieces('♘')
  end

  def _add_bishops
    _add_pieces('♗')
  end

  def _add_queens
    _add_pieces('♕')
  end

  def _add_kings
    _add_pieces('♔')
  end

  def _add_pieces_to_board_display
    @pieces.each do |piece|
      y = piece.coordinate[0]
      x = piece.coordinate[1]
      @board_display[y][x][1] = piece.active? ? piece.unicode : ' '
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
  test = board.start_game
  puts test
end
