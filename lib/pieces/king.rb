# frozen_string_literal: true

require './lib/pieces/chess_piece'

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

    x = @coordinate[1]
    y = @coordinate[0]

    _add_to_possible_paths(_create_path([y, x + 2], tags),
                           _create_path([y, x - 2], tags))
  end

  def _add_normal_paths(tags = %i[check_move check_attack])
    x = @coordinate[1]
    y = @coordinate[0]

    (-1..1).each do |i|
      (-1..1).each do |j|
        next if i.zero? && j.zero?

        _add_to_possible_paths(_create_path([y + j, x + i], tags))
      end
    end
  end

  def _fill_paths_arr
    _add_castling_paths
    _add_normal_paths
  end
end

if __FILE__ == $PROGRAM_NAME
  piece = King.new(WHITE_PIECE, 'e1')
  piece.generate_possible_moves
  piece.move('e2')
  piece.generate_possible_moves
  puts
end
