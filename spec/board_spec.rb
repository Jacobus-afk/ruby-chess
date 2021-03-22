# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './lib/board'
require './lib/colors'

# RSpec.configure do |config|
#   config.expect_with :rspec do |c|
#     c.max_formatted_output_length = 1000000
#   end
# end

describe Board do
  subject(:board) { described_class.new }
  white = "\e[30;107m   \e[0m"
  black = "\e[30;100m   \e[0m"
  describe '#draw_board' do
    it 'draws template correctly' do
      expect(board.draw_board).to eql(["#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                                       "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}",
                                       "#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                                       "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}",
                                       "#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                                       "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}",
                                       "#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                                       "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}"])
    end

    it 'handles inactive pieces correctly' do
      inactive = instance_double('ChessPiece', coordinate: [0, 0], unicode: '♕')
      board.instance_variable_set(:@pieces, [inactive])
      allow(inactive).to receive(:active?).and_return(false)

      expect(board.draw_board).to eql(["#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                                       "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}",
                                       "#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                                       "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}",
                                       "#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                                       "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}",
                                       "#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                                       "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}"])
    end

    it 'handles active pieces correctly' do
      active = instance_double('ChessPiece', coordinate: [1, 2], unicode: '♘')
      board.instance_variable_set(:@pieces, [active])
      allow(active).to receive(:active?).and_return(true)

      expect(board.draw_board).to eql(["#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                                       "#{black}#{white}" + ' ♘ '.black_bg + "#{white}#{black}#{white}#{black}#{white}",
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
      expect(board.start_game).to eq([' ♜ '.white_bg + ' ♞ '.black_bg + ' ♝ '.white_bg + ' ♛ '.black_bg +
                                       ' ♚ '.white_bg + ' ♝ '.black_bg + ' ♞ '.white_bg + ' ♜ '.black_bg,
                                      ' ♟ '.black_bg + ' ♟ '.white_bg + ' ♟ '.black_bg + ' ♟ '.white_bg +
                                      ' ♟ '.black_bg + ' ♟ '.white_bg + ' ♟ '.black_bg + ' ♟ '.white_bg,
                                      "#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                                      "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}",
                                      "#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                                      "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}",
                                      ' ♙ '.white_bg + ' ♙ '.black_bg + ' ♙ '.white_bg + ' ♙ '.black_bg +
                                      ' ♙ '.white_bg + ' ♙ '.black_bg + ' ♙ '.white_bg + ' ♙ '.black_bg,
                                      ' ♖ '.black_bg + ' ♘ '.white_bg + ' ♗ '.black_bg + ' ♕ '.white_bg +
                                      ' ♔ '.black_bg + ' ♗ '.white_bg + ' ♘ '.black_bg + ' ♖ '.white_bg])
    end
  end
end

# rubocop:enable Metrics/BlockLength
