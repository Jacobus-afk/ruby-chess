# frozen_string_literal: true

# chess piece class
class ChessPiece
  attr_reader :unicode

  def initialize(icon)
    @unicode = icon
  end
end

if __FILE__ == $PROGRAM_NAME
  piece = ChessPiece.new('♞')
  puts piece || '*'
end
