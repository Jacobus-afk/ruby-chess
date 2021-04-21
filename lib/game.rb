# frozen_string_literal: true

require './lib/keys'
require './lib/board'
require './lib/player'
require './lib/pieces/chess_piece'

SELECT_PIECE = 0
MOVE_PIECE = 1

PIECE_METHOD = { SELECT_PIECE => :_select_piece,
                 MOVE_PIECE => :_move_piece }.freeze

# state machine class
class StateMachine
  attr_reader :piece_state, :current_player, :players
  def initialize
    @players = [Player.new(WHITE_PIECE, 'a1'),
                Player.new(BLACK_PIECE, 'h8')]
    @piece_state = SELECT_PIECE
    @current_player = _find_active_player
  end

  def toggle_state
    @piece_state = (@piece_state + 1) % 2
  end

  private

  def _find_active_player
    @players.each do |player|
      return player if player.active
    end
  end
end

# gameengine class
class SelectionHandler
  include Coordinator

  def initialize(board, state_machine)
    @board = board
    @state_machine = state_machine
  end

  def update_board_paths(possible_paths)
    _update_paths(possible_paths)
    _add_paths_to_board(possible_paths)
  end

  private

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
  end

  def _update_paths(paths)
    paths.each do |path|
      path.data.tags.reverse_each do |tag|
        send(tag, path)
      end
    end
  end

  def _check_move(path)
    return if path.next.nil?

    next_pos = path.next.data.position
    return _check_move(path.next) unless @board.pieces.key?(next_pos)

    path.next.data.remove_tag(:_check_move)
    path.next.next = nil
  end

  def _check_attack(path)
    return if path.next.nil?

    unless _check_for_enemy_piece(path.next.data.position)
      path.next.data.remove_tag(:_check_attack)
      return _check_attack(path.next)
    end

    path.next.next = nil
  end

  def _check_enpassant(path)
    return if path.next.nil?

    enpassant_coord = translate_position(path.next.data.position)
    path.next.data.remove_tag(:_check_enpassant) unless _check_for_adjacent_en_passant_pawn(enpassant_coord)
  end

  def _check_castling(path)
    return if path.next.nil?
  end

  def _check_for_enemy_piece(pos)
    piece = @board.pieces.fetch(pos, nil)

    true unless piece.nil? || piece.team == @state_machine.current_player.team
  end

  def _check_for_adjacent_en_passant_pawn(enpassant_coord)
    pos, = move_attempt(PAWN_ENPASSANT_CHECK[@state_machine.current_player.team], enpassant_coord)
    piece = @board.pieces.fetch(pos, nil)

    true if !piece.nil? && piece.is_a?(Pawn) && piece.team != @state_machine.current_player.team && piece.en_passant?
  end
end

# class PlayerInput
class PlayerInput
  include Keypress

  def handle_command
    loop do
      input = read_single_key
      return input unless input.nil?
    end
  end
end

# game class
class Game
  def initialize
    # @current_player = _find_active_player
    # @players = [Player.new(WHITE_PIECE, 'a1'),
    #             Player.new(BLACK_PIECE, 'h8')]
    @player_input = PlayerInput.new
    @state_machine = StateMachine.new
    @board = Board.new(@state_machine.players)
    @selection_handler = SelectionHandler.new(@board, @state_machine)
    @valid_move = false
    @current_piece = nil
    @active_game = true
  end

  def start_game
    @board.start_game
    loop do
      _draw_board
      _handle_player_input
      break unless @active_game
    end
  end

  private

  def _draw_board
    system('clear') || system('cls')
    puts @board.draw_board
  end

  def _handle_player_input
    cmd = @player_input.handle_command
    _confirm_action if cmd == :enter
    _cancel_or_menu if cmd == :esc

    _move_player_pointer(cmd) if %i[move_left move_right move_up move_down].include?(cmd)
  end

  # def _update_paths(paths)
  #   paths.each do |path|
  #     path.data.tags.reverse_each do |tag|
  #       send(tag, path)
  #     end
  #   end
  # end

  # def _traverse_path_and_add_coords(path)
  #   return if path.nil? || path.data.tags == []

  #   coords = translate_position(path.data.position)
  #   @board.current_paths[coords] = true
  #   _traverse_path_and_add_coords(path.next)
  # end

  # def _add_paths_to_board(paths)
  #   @board.current_paths = {}
  #   paths.each do |path|
  #     _traverse_path_and_add_coords(path.next)
  #   end
  # end

  def _select_piece
    pos = @state_machine.current_player.position
    piece = @board.pieces.fetch(pos, nil)
    return false if piece.nil? || piece.team != @state_machine.current_player.team

    @current_piece = piece
    @board.tile_selection = @state_machine.current_player.coordinate

    @selection_handler.update_board_paths(piece.possible_paths)
    # _update_paths(piece.possible_paths)
    # _add_paths_to_board(piece.possible_paths)
  end

  def _move_piece
    true
  end

  def _confirm_action
    @state_machine.toggle_state if send(PIECE_METHOD[@state_machine.piece_state])
  end

  def _cancel_or_menu; end

  def _move_player_pointer(move)
    @state_machine.current_player.send(move)
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  puts game.start_game
end
