# frozen_string_literal: true

require './lib/pieces/chess_piece'

KNIGHT_VECTORS = [[1, -2], [2, -1], [2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2]].freeze

# Knight class
class Knight < ChessPiece
  def initialize(team, pos)
    super(team, '♘', pos)
  end

  def generate_possible_moves
    super
    _fill_paths_arr
  end

  private

  def _fill_paths_arr(tags = %i[_check_move _check_attack])
    KNIGHT_VECTORS.each do |vector|
      path = _create_single_path(vector, tags)
      @possible_paths.append(path) unless path.nil?
    end
  end
end
