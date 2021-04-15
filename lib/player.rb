# frozen_string_literal: true

require './lib/pieces/chess_piece'

# player class
class Player
  attr_accessor :active
  attr_reader :team, :coordinate

  include Coordinator

  def initialize(team, pos)
    @team = team
    @position = pos
    @coordinate = translate_position(@position)
    @active = team == WHITE_PIECE
  end

  def move_left
    _move_attempt([0, -1])
  end

  def move_right
    _move_attempt([0, 1])
  end

  def move_down
    _move_attempt([1, 0])
  end

  def move_up
    _move_attempt([-1, 0])
  end

  private

  def _move_attempt(vector)
    pos, coord = move_attempt(vector, @coordinate)
    return if pos.nil?

    @position = pos
    @coordinate = coord
  end
end

if __FILE__ == $PROGRAM_NAME
  test = Player.new(WHITE_PIECE, 'a3')
  puts test
end
