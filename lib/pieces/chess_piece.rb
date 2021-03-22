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

# chess piece class
class ChessPiece
  attr_reader :team, :unicode, :coordinate

  def initialize(team, icon, pos, promoted = false)
    @team = team
    @promoted = promoted
    @icon = icon
    @unicode = PIECE_DATA[icon][team][:unicode]
    @position = pos
    @active = _valid_start_conditions?
    @coordinate = _translate_position
  end

  def active?
    @active
  end

  def in_grid?(pos)
    true if pos.length == 2 && pos[0].match?(/[[A-Ha-h]]/) && pos[1].match?(/[[1-9]]/)
  end

  def deactivate
    @active = false
  end

  def move(pos)
    return unless @active && in_grid?(pos)

    @position = pos
    @coordinate = _translate_position
  end

  private

  def _translate_position
    y = (@position[1].to_i - 8) * -1
    x = @position[0].upcase.ord - 65
    [y, x]
  end

  def _valid_start_conditions?
    true if in_grid?(@position) && (_valid_start_pos? || @promoted)
  end

  def _valid_start_pos?
    true if PIECE_DATA[@icon][team][:start_pos].include? @position
  end
end

PIECE_CLASSES = { '♖' => ChessPiece, '♘' => ChessPiece, '♗' => ChessPiece,
                  '♕' => ChessPiece, '♔' => ChessPiece, '♙' => ChessPiece }.freeze

if __FILE__ == $PROGRAM_NAME
  piece = ChessPiece.new(BLACK_PIECE, '♘', 'a6')
  puts piece
end
