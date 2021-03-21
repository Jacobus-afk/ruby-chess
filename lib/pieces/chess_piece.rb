# frozen_string_literal: true

WHITE_PIECE = 0
BLACK_PIECE = 1

# teams module
module Teams
  %i[WHITE_PIECE BLACK_PIECE].freeze

end

# chess piece class
class ChessPiece
  include Teams

  attr_reader :team, :unicode, :position

  def initialize(team, icon, pos)
    @team = team
    @unicode = (icon.ord + (6 * team)).chr(Encoding::UTF_8)
    @position = pos
    @active = true
  end

  def active?
    @active
  end

  def deactivate
    @active = false
  end
end

if __FILE__ == $PROGRAM_NAME
  piece = ChessPiece.new(BLACK_PIECE, '♘', 'a6')
  puts
end
