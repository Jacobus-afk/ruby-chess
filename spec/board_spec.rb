# frozen_string_literal: true

require './lib/board'
require './lib/colors'

describe Board do
  subject(:board) { described_class.new }
  white = "\e[30;107m   \e[0m"
  black = "\e[30;100m   \e[0m"
  describe '#draw_board' do
    it 'draws template correctly' do
      # black_text = "\e[30m♚\e[0m"
      expect(board.draw_board).to eql(["#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                                       "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}",
                                       "#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                                       "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}",
                                       "#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                                       "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}",
                                       "#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                                       "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}"])
    end
  end

  describe '#start_game' do
    it 'draws pieces for a new game correctly' do
      expect(board.start_game).to eql([' ♜ '.white_bg + ' ♞ '.black_bg + ' ♝ '.white_bg + ' ♛ '.black_bg +
                                       ' ♚ '.white_bg + ' ♝ '.black_bg + ' ♞ '.white_bg + ' ♜ '.black_bg,
                                       ' ♟︎ '.black_bg + ' ♟︎ '.white_bg + ' ♟︎ '.black_bg + ' ♟︎ '.white_bg +
                                       ' ♟︎ '.black_bg + ' ♟︎ '.white_bg + ' ♟︎ '.black_bg + ' ♟︎ '.white_bg,
                                       "#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                                       "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}",
                                       "#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                                       "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}",
                                       ' ♖ '.white_bg + ' ♘ '.black_bg + ' ♗ '.white_bg + ' ♕ '.black_bg +
                                       ' ♔ '.white_bg + ' ♗ '.black_bg + ' ♘ '.white_bg + ' ♖ '.black_bg,
                                       ' ♙ '.black_bg + ' ♙ '.white_bg + ' ♙ '.black_bg + ' ♙ '.white_bg +
                                       ' ♙ '.black_bg + ' ♙ '.white_bg + ' ♙ '.black_bg + ' ♙ '.white_bg,])
    end
  end
end
