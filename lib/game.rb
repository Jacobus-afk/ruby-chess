# frozen_string_literal: true

require './lib/keys'
require './lib/board'
require './lib/pieces/chess_piece'

SELECT_PIECE = 0
MOVE_PIECE = 1

PIECE_METHOD = { SELECT_PIECE => :_select_piece,
                 MOVE_PIECE => :_move_piece }.freeze
# game class
class Game
  include Keypress
  include Coordinator
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

  def _check_move(path)
    return if path.next.nil?

    next_pos = path.next.data.position

    return _check_move(path.next) unless @board.pieces.key?(next_pos)

    path.next.data.remove_tag(:_check_move)

    path.next.next = nil
    # @board.pieces.key?(next_pos) ? path.next.data.remove_tag(:_check_move) : _check_move(path.next)
  end

  def _check_for_enemy_piece(pos)
    piece = @board.pieces.fetch(pos, nil)

    true unless piece.nil? || piece.team == @current_player.team
  end

  def _check_attack(path)
    return if path.next.nil?

    unless _check_for_enemy_piece(path.next.data.position)
      path.next.data.remove_tag(:_check_attack)
      return _check_attack(path.next)
    end

    path.next.next = nil
    # path.next.data.remove_tag(:_check_attack)
    # _check_attack(path.next)
    # _check_for_enemy_piece(path.next.data.position) ? _check_attack(path.next) : path.data.remove_tag(:_check_attack)
  end

  def _check_for_adjacent_en_passant_pawn(enpassant_coord)
    pos, = move_attempt(PAWN_ENPASSANT_CHECK[@current_player.team], enpassant_coord)
    piece = @board.pieces.fetch(pos, nil)

    true if !piece.nil? && piece.is_a?(Pawn) && piece.team != @current_player.team && piece.en_passant?
  end

  def _check_enpassant(path)
    return if path.next.nil?

    enpassant_coord = translate_position(path.next.data.position)
    path.data.remove_tag(:_check_enpassant) unless _check_for_adjacent_en_passant_pawn(enpassant_coord)
  end

  def _check_castling(_path)
    return if path.next.nil?


  end

  def _update_paths(paths)
    paths.each do |path|
      # pos = path.position
      path.data.tags.reverse_each do |tag|
        send(tag, path)
      end
    end
  end

  def _traverse_path_and_add_coords(path)
    return if path.nil? || path.data.tags == []

    coords = translate_position(path.data.position)
    @board.current_paths[coords] = true
    _traverse_path_and_add_coords(path.next)
  end

  def _add_paths_to_board(paths)
    @board.current_paths = {}
    paths.each do |path|
      _traverse_path_and_add_coords(path.next)
    end
    # @board.current_paths.append(path.next) unless path.next.nil?
  end

  def _select_piece
    pos = @current_player.position
    piece = @board.pieces.fetch(pos, nil)
    return false if piece.nil? || piece.team != @current_player.team

    @current_piece = piece
    @board.tile_selection = @current_player.coordinate

    _update_paths(piece.possible_paths)
    _add_paths_to_board(piece.possible_paths)
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
