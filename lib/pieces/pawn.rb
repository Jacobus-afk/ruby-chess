# frozen_string_literal: true

require './lib/pieces/chess_piece'

WHITE_PAWN_ATTACK_VECTORS = [[-1, -1], [-1, 1]].freeze
WHITE_PAWN_MOVE_VECTORS = [[-1, 0], [-2, 0]].freeze
BLACK_PAWN_ATTACK_VECTORS = [[1, -1], [1, 1]].freeze
BLACK_PAWN_MOVE_VECTORS = [[1, 0], [2, 0]].freeze
PAWN_ATTACK_VECTORS = [WHITE_PAWN_ATTACK_VECTORS, BLACK_PAWN_ATTACK_VECTORS].freeze
PAWN_MOVE_VECTORS = [WHITE_PAWN_MOVE_VECTORS, BLACK_PAWN_MOVE_VECTORS].freeze

# Pawn class
class Pawn < ChessPiece
  def initialize(team, pos)
    super(team, '♙', pos)
    @promoted = false
    @en_passant = false
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
    super
    _fill_paths_arr
  end

  private

  def _check_for_en_passant(planned_move)
    @en_passant = false
    return unless first_move?

    y = find_coordinate(planned_move)[0]
    @en_passant = true if (@coordinate[0] - y).abs == 2
  end

  def _check_for_promotion
    @promoted = true if @coordinate[0].zero? || @coordinate[0] == 7
  end

  def _add_attack_paths
    PAWN_ATTACK_VECTORS[@team].each do |vector|
      path = _create_single_path(vector, %i[check_move check_enpassant check_attack])
      @possible_paths.append(path) unless path.nil?
    end
  end

  def _add_normal_paths
    PAWN_MOVE_VECTORS[@team].each do |vector|
      path = _create_single_path(vector, %i[check_move])
      @possible_paths.append(path) unless path.nil?
      break unless first_move?
    end
  end

  def _fill_paths_arr
    _add_attack_paths
    _add_normal_paths
  end
end

if __FILE__ == $PROGRAM_NAME
  # require './spec/pieces/linked_list_helper.rb'
  # include LinkedListHelper
  piece = Pawn.new(BLACK_PIECE, 'c7')
  piece.move('c5')

  # test = LinkedListHelper.extract_path_positions(piece.possible_paths)
  puts
end
