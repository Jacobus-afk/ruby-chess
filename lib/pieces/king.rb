# frozen_string_literal: true

require './lib/pieces/chess_piece'

KING_CASTLING_VECTORS = [[0, 2], [0, -2]].freeze
KING_MOVE_VECTORS = [[1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1]].freeze

# King class
class King < ChessPiece
  def initialize(team, pos)
    super(team, '♔', pos)
    @castling = false
  end

  def castling?
    @castling
  end

  def move(pos)
    _check_for_castling(pos)
    super(pos)
  end

  def generate_possible_moves
    super
    _fill_paths_arr
  end

  private

  def _check_for_castling(planned_move)
    @castling = false
    return unless first_move?

    x = find_coordinate(planned_move)[1]
    @castling = true if (@coordinate[1] - x).abs == 2
  end

  def _add_to_possible_paths(*paths)
    paths.each do |path|
      next if path.nil?

      @possible_paths.push(path)
    end
  end

  def _create_path(move, tags)
    pos = find_position(move)
    return if pos.nil?

    Node.new(pos => tags)
  end

  def _add_castling_paths(tags = %i[check_move check_castling])
    return unless first_move?

    KING_CASTLING_VECTORS.each do |vector|
      path = _create_single_path(vector, tags)
      @possible_paths.append(path) unless path.nil?
    end
  end

  def _add_normal_paths(tags = %i[check_move check_attack])
    KING_MOVE_VECTORS.each do |vector|
      path = _create_single_path(vector, tags)
      @possible_paths.append(path) unless path.nil?
    end
  end

  def _fill_paths_arr
    _add_castling_paths
    _add_normal_paths
  end
end

if __FILE__ == $PROGRAM_NAME
  piece = King.new(WHITE_PIECE, 'e1')
  piece.move('e2')
  puts
end
