# frozen_string_literal: true

require './lib/keys'
require './lib/board'

SELECT_PIECE = 0
MOVE_PIECE = 1

PIECE_METHOD = { SELECT_PIECE => :_select_piece,
                 MOVE_PIECE => :_move_piece }.freeze
# game class
class Game
  include Keypress

  def initialize
    @board = Board.new
    @current_player = _find_active_player
    @piecestate = SELECT_PIECE
    # @piecemethodhash = { SELECT_PIECE => _select_piece,
    #                      MOVE_PIECE => _move_piece }
    @valid_move = false
    @current_piece = nil
    @active_game = true
  end

  def handle_player_input
    _handle_command(_player_input)
  end

  def start_game
    @board.start_game
    loop do
      _draw_board
      _handle_command(_player_input)
      break unless @active_game
    end
  end

  private

  def _draw_board
    system('clear') || system('cls')
    puts @board.draw_board
  end

  def _toggle_piecestate
    @piecestate = (@piecestate + 1) % 2
  end

  def _select_piece
    pos = @current_player.position
    piece = @board.pieces.fetch(pos, nil)
    return false if piece.nil?

    @board.tile_selection = @current_player.coordinate
  end

  def _move_piece
    true
  end

  def _find_active_player
    @board.players.each do |player|
      return player if player.active
    end
  end

  def _player_input
    loop do
      input = read_single_key
      return input unless input.nil?
    end
  end

  def _handle_enter
    _toggle_piecestate if send(PIECE_METHOD[@piecestate])
  end

  def _handle_esc; end

  def _handle_move(move)
    @current_player.send(move)
  end

  def _handle_command(input)
    return if input.nil?

    _handle_enter if input == :enter
    _handle_esc if input == :esc

    _handle_move(input) if %i[move_left move_right move_up move_down].include?(input)
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  puts game.start_game
end
