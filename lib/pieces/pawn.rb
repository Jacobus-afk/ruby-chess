# frozen_string_literal: true

require './lib/pieces/chess_piece'

# Pawn class
class Pawn < ChessPiece
  def initialize(team, pos)
    super(team, '♙', pos)
    @promoted = false
    @en_passant = false
    # @moves_hash = {}
  end

  def en_passant?
    @en_passant
  end

  def promoted?
    @promoted
  end

  def move(pos)
    _check_for_en_passant(pos)
    super(pos)
    _check_for_promotion
  end

  def generate_possible_moves
    _fill_moves_arr

    # possible_moves.filter_map do |move|
    #   find_position(move)
    # end
  end

  private

  def _check_for_en_passant(planned_move)
    @en_passant = false
    return unless first_move?

    y = (planned_move[1].to_i - 8) * -1
    @en_passant = true if (@coordinate[0] - y).abs == 2
  end

  def _check_for_promotion
    @promoted = true if @coordinate[0].zero? || @coordinate[0] == 7
  end

  def move_one_forward(val)
    team == BLACK_PIECE ? val + 1 : val - 1
  end

  def _translate_to_possible_path(move, tags)
    pos = find_position(move)
    return if pos.nil?

    move = Node.new(pos => tags)
    @possible_paths.push(move)
    # path = create_new path
    # add_move_to_path
    # @moves_hash[pos] = tags

    # @possible_moves.push(PossibleMove.new(pos, tags))
  end

  def _add_attack_path(move)
    _translate_to_possible_path(move, %i[check_move check_enpassant check_attack])
  end

  def _add_normal_path(move)
    _translate_to_possible_path(move, %i[check_move])
  end

  def _fill_moves_arr
    @possible_paths = []
    x = @coordinate[1]
    y = move_one_forward(@coordinate[0])
    _add_attack_path([y, x - 1])
    _add_attack_path([y, x + 1])
    _add_normal_path([y, x])
    _add_normal_path([move_one_forward(y), x]) if first_move?
  end

  # def _fill_moves_arr(xvar = @coordinate[1], yvar = @coordinate[0])
  #   moves_arr = []
  #   y = _move_one(yvar)
  #   moves_arr.push([y, xvar - 1])
  #   moves_arr.push([y, xvar])
  #   moves_arr.push([y, xvar + 1])
  #   moves_arr.push([_move_one(y), xvar]) if first_move?
  #   moves_arr
  # end
end

if __FILE__ == $PROGRAM_NAME
  # require './spec/pieces/linked_list_helper.rb'
  # include LinkedListHelper
  piece = Pawn.new(BLACK_PIECE, 'c7')
  piece.move('c5')
  piece.generate_possible_moves

  test = LinkedListHelper.extract_path_positions(piece.possible_paths)
  puts test
end
