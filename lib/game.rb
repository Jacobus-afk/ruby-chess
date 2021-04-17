# frozen_string_literal: true

require './lib/keys.rb'

# game class
class Game
  include Keypress

  def player_input
    loop do
      input = read_single_key
      return input unless input.nil?
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  puts game.player_input
end
