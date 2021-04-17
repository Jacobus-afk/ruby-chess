# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './lib/board'
require './lib/colors'

# RSpec.configure do |config|
#   config.expect_with :rspec do |c|
#     c.max_formatted_output_length = 1_000_000
#   end
# end

describe Board do
  white = "\e[30;107m   \e[0m"
  black = "\e[30;100m   \e[0m"
  red = "\e[30;101m   \e[0m"
  blue = "\e[30;106m   \e[0m"
  board_template = ["#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                    "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}",
                    "#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                    "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}",
                    "#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                    "#{black}#{white}#{black}#{white}#{black}#{white}#{black}#{white}",
                    "#{white}#{black}#{white}#{black}#{white}#{black}#{white}#{black}",
                    "#{red}#{white}#{black}#{white}#{black}#{white}#{black}#{white}"]

  subject(:board) { described_class.new }
  let(:drawn_board) { board_template.dup }

  context 'when instantiating class' do
    it 'initializes variables correcty' do
      expect(board.pieces).to eql({})
      expect(board.tile_selection).to eql([-1, -1])
    end
    it 'sets players up' do
      expect(board.players).to be_a(Array)
      expect(board.players[0].team).to eql(WHITE_PIECE)
      expect(board.players[1].team).to eql(BLACK_PIECE)
    end
  end

  describe '#draw_board' do
    let(:chesspiece) { instance_double(ChessPiece, coordinate: [1, 2], unicode: '♘') }

    it 'draws template correctly' do
      expect(board.draw_board).to eql(drawn_board)
    end

    it 'handles inactive pieces correctly' do
      board.instance_variable_set(:@pieces, { 'a8' => chesspiece })
      allow(chesspiece).to receive(:active?).and_return(false)
      expect(board.draw_board).to eql(drawn_board)
    end

    it 'handles active pieces correctly' do
      board.instance_variable_set(:@pieces, { 'c7' => chesspiece })
      allow(chesspiece).to receive(:active?).and_return(true)
      drawn_board[1] = "#{black}#{white}" + ' ♘ '.black_bg + "#{white}#{black}#{white}#{black}#{white}"
      expect(board.draw_board).to eql(drawn_board)
    end

    it 'handles tile selection correctly' do
      board.tile_selection = [5, 0]
      drawn_board[5] = "#{blue}#{white}#{black}#{white}#{black}#{white}#{black}#{white}"
      expect(board.draw_board).to eql(drawn_board)
    end
  end

  describe '#start_game' do
    it 'draws pieces for a new game correctly' do
      drawn_board[0] = ' ♜ '.white_bg + ' ♞ '.black_bg + ' ♝ '.white_bg + ' ♛ '.black_bg +
                       ' ♚ '.white_bg + ' ♝ '.black_bg + ' ♞ '.white_bg + ' ♜ '.black_bg
      drawn_board[1] = ' ♟ '.black_bg + ' ♟ '.white_bg + ' ♟ '.black_bg + ' ♟ '.white_bg +
                       ' ♟ '.black_bg + ' ♟ '.white_bg + ' ♟ '.black_bg + ' ♟ '.white_bg
      drawn_board[6] = ' ♙ '.white_bg + ' ♙ '.black_bg + ' ♙ '.white_bg + ' ♙ '.black_bg +
                       ' ♙ '.white_bg + ' ♙ '.black_bg + ' ♙ '.white_bg + ' ♙ '.black_bg
      drawn_board[7] = ' ♖ '.red_bg + ' ♘ '.white_bg + ' ♗ '.black_bg + ' ♕ '.white_bg +
                       ' ♔ '.black_bg + ' ♗ '.white_bg + ' ♘ '.black_bg + ' ♖ '.white_bg
      board.start_game
      expect(board.draw_board).to eql(drawn_board)
    end
  end
end

# rubocop:enable Metrics/BlockLength
