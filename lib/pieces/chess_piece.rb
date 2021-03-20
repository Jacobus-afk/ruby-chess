# frozen_string_literal: true

# chess piece class
class ChessPiece
  attr_reader :team, :unicode, :position

  def initialize(team, icon, pos)
    @team = team
    @unicode = icon
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
  piece = ChessPiece.new('♞')
  puts piece || '*'
end
