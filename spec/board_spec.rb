# frozen_string_literal: true

require './lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#draw_board' do
    it 'draws template correctly' do
      white = "\e[107m   \e[0m"
      black = "\e[100m   \e[0m"
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

    it 'draws pieces for a new game correctly' do
      
    end
  end
end
