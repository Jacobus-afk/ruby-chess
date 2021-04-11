# frozen_string_literal: true

require './lib/pieces/chess_piece'

BISHOP_VECTORS = [[-1, -1], [-1, 1], [1, 1], [1, -1]].freeze

# Bishop class
class Bishop < ChessPiece
  def initialize(team, pos)
    super(team, '♗', pos)
  end

  def generate_possible_moves
    super
    _fill_paths_arr
  end

  private

  def _move_attempt(travelvector, basecoord)
    # https://stackoverflow.com/questions/1009280/how-do-i-perform-vector-addition-in-ruby
    move_attempt = travelvector.zip(basecoord).map { |x1, x2| x1 + x2 }
    [find_position(move_attempt), move_attempt]
  end

  def _create_path(travelvector, basecoord = @coordinate, rootnode = nil, tags = %i[check_move check_attack])
    pos, coord = _move_attempt(travelvector, basecoord)
    return if pos.nil?

    node = Node.new(pos => tags)
    rootnode ? rootnode.append(node) : rootnode = node

    _create_path(travelvector, coord, rootnode)
    rootnode
  end

  def _fill_paths_arr
    BISHOP_VECTORS.each do |vector|
      path = _create_path(vector)
      @possible_paths.append(path) unless path.nil?
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  piece = Bishop.new(WHITE_PIECE, 'c8')
  piece.generate_possible_moves
  piece.move('f5')
  piece.generate_possible_moves
  puts
end
