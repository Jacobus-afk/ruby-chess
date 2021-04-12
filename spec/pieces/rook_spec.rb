# frozen_string_literal: true

require './lib/pieces/rook'
require './spec/pieces/linked_list_helper'

describe Rook do
  subject(:rook_white_white_square) { described_class.new(WHITE_PIECE, 'h1') }
  subject(:rook_white_black_square) { described_class.new(WHITE_PIECE, 'a1') }
  subject(:rook_black_white_square) { described_class.new(BLACK_PIECE, 'a8') }
  subject(:rook_black_black_square) { described_class.new(BLACK_PIECE, 'h8') }

  describe '#generate_possible_moves' do
    it "rook's first move" do
      white_white_square = extract_path_positions(rook_white_white_square.possible_paths)
      white_black_square = extract_path_positions(rook_white_black_square.possible_paths)
      black_white_square = extract_path_positions(rook_black_white_square.possible_paths)
      black_black_square = extract_path_positions(rook_black_black_square.possible_paths)
      expect(white_white_square).to contain_exactly('a1', 'b1', 'c1', 'd1', 'e1', 'f1', 'g1',
                                                    'h2', 'h3', 'h4', 'h5', 'h6', 'h7', 'h8')
      expect(white_black_square).to contain_exactly('b1', 'c1', 'd1', 'e1', 'f1', 'g1', 'h1',
                                                    'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8')
      expect(black_white_square).to contain_exactly('b8', 'c8', 'd8', 'e8', 'f8', 'g8', 'h8',
                                                    'a7', 'a6', 'a5', 'a4', 'a3', 'a2', 'a1')
      expect(black_black_square).to contain_exactly('a8', 'b8', 'c8', 'd8', 'e8', 'f8', 'g8',
                                                    'h7', 'h6', 'h5', 'h4', 'h3', 'h2', 'h1')
    end
  end
end
