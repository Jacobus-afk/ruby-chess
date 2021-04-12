# frozen_string_literal: true

WHITE_PIECE = 0
BLACK_PIECE = 1

PIECE_DATA = { '♖' => { WHITE_PIECE => { unicode: '♖', start_pos: %w[a1 h1] },
                        BLACK_PIECE => { unicode: '♜', start_pos: %w[a8 h8] } },
               '♘' => { WHITE_PIECE => { unicode: '♘', start_pos: %w[b1 g1] },
                        BLACK_PIECE => { unicode: '♞', start_pos: %w[b8 g8] } },
               '♗' => { WHITE_PIECE => { unicode: '♗', start_pos: %w[c1 f1] },
                        BLACK_PIECE => { unicode: '♝', start_pos: %w[c8 f8] } },
               '♕' => { WHITE_PIECE => { unicode: '♕', start_pos: %w[d1] },
                        BLACK_PIECE => { unicode: '♛', start_pos: %w[d8] } },
               '♔' => { WHITE_PIECE => { unicode: '♔', start_pos: %w[e1] },
                        BLACK_PIECE => { unicode: '♚', start_pos: %w[e8] } },
               '♙' => { WHITE_PIECE => { unicode: '♙', start_pos: %w[a2 b2 c2 d2 e2 f2 g2 h2] },
                        BLACK_PIECE => { unicode: '♟', start_pos: %w[a7 b7 c7 d7 e7 f7 g7 h7] } } }.freeze

MOVE_TAGS = %i[check_move check_attack check_enpassant check_castling].freeze

# node class
class Node
  attr_accessor :next
  attr_reader :data
  def initialize(data)
    @data = data
    @next = nil
  end

  def append(node)
    @next ? @next.append(node) : @next = node
  end

  def find(val)
    return @data if @data.keys[0] == val

    @next&.find(val)
  end
end

# chess piece class
class ChessPiece
  attr_accessor :possible_paths
  attr_reader :team, :unicode, :coordinate

  def initialize(team, icon, pos, promoted = false)
    @possible_paths = []
    @team = team
    @promoted = promoted
    @icon = icon
    @unicode = PIECE_DATA[icon][team][:unicode]
    @position = pos
    @active = _valid_start_conditions?
    @coordinate = _translate_position
    @first_move = true
    generate_possible_moves
  end

  def active?
    @active
  end

  def first_move?
    @first_move
  end

  def find_position(coord)
    return unless (coord.is_a? Array) && coord.length == 2

    pos = _translate_coord(coord)
    pos if _in_grid?(pos)
  end

  def generate_possible_moves(vectors = nil)
    @possible_paths = []
    _fill_paths_array(vectors)
  end

  def find_coordinate(pos)
    return unless _in_grid?(pos)

    _translate_position(pos)
  end

  def deactivate
    @active = false
  end

  def move(pos)
    return unless @active && _in_paths?(pos) && _in_grid?(pos)

    @position = pos
    @coordinate = _translate_position
    @first_move = false
    generate_possible_moves
  end

  private

  def _move_attempt(travelvector, basecoord)
    # https://stackoverflow.com/questions/1009280/how-do-i-perform-vector-addition-in-ruby
    move_attempt = travelvector.zip(basecoord).map { |x1, x2| x1 + x2 }
    [find_position(move_attempt), move_attempt]
  end

  def _create_single_path(travelvector, tags, basecoord = @coordinate)
    pos, = _move_attempt(travelvector, basecoord)
    return if pos.nil?

    Node.new(pos => tags)
  end

  def _create_multi_path(travelvector, tags = %i[check_move check_attack], basecoord = @coordinate, rootnode = nil)
    pos, coord = _move_attempt(travelvector, basecoord)
    return if pos.nil?

    node = Node.new(pos => tags)
    rootnode ? rootnode.append(node) : rootnode = node

    _create_multi_path(travelvector, tags, coord, rootnode)
    rootnode
  end

  def _fill_paths_array(vectors)
    return if vectors.nil?

    vectors.each do |vector|
      path = _create_multi_path(vector)
      @possible_paths.append(path) unless path.nil?
    end
  end

  def _in_paths?(pos)
    @possible_paths.each do |path|
      return true if path.find(pos)
    end
    false
  end

  def _in_grid?(pos)
    true if (pos.is_a? String) && pos.length == 2 && pos[0].match?(/[[A-Ha-h]]/) && pos[1].match?(/[[1-8]]/)
  end

  def _translate_coord(coord)
    x = (coord[1] + 97).chr
    y = ((coord[0] * -1) + 8).to_s
    x + y
  end

  def _translate_position(pos = @position)
    y = (pos[1].to_i - 8) * -1
    x = pos[0].downcase.ord - 97
    [y, x]
  end

  def _valid_start_conditions?
    true if _in_grid?(@position) && (_valid_start_pos? || @promoted)
  end

  def _valid_start_pos?
    true if PIECE_DATA[@icon][team][:start_pos].include? @position
  end
end

if __FILE__ == $PROGRAM_NAME
  piece = ChessPiece.new(BLACK_PIECE, '♘', 'a6')
  piece.find_position([7, 7])

  node = Node.new('a1' => %i[check_move check_attack])
  node.append(Node.new('a2' => %i[check_move]))
  node.append(Node.new('a3' => %i[check_enpassant]))

  test = node.find('a3')
  puts test
end
