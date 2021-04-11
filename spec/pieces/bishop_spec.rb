# frozen_string_literal: true

require './lib/pieces/bishop'
require './spec/pieces/linked_list_helper'

describe Bishop do
  subject(:bishop_white_white_square) { described_class.new(WHITE_PIECE, 'f1') }
  subject(:bishop_white_black_square) { described_class.new(WHITE_PIECE, 'c1') }
  subject(:bishop_black_white_square) { described_class.new(WHITE_PIECE, 'c8') }
  subject(:bishop_black_black_square) { described_class.new(WHITE_PIECE, 'f8') }

  before(:each) do
    bishop_white_white_square.generate_possible_moves
    bishop_white_black_square.generate_possible_moves
    bishop_black_white_square.generate_possible_moves
    bishop_black_black_square.generate_possible_moves
  end
  describe '#generate_possible_moves' do
    it "bishop's first move" do
      white_white_square = extract_path_positions(bishop_white_white_square.possible_paths)
      white_black_square = extract_path_positions(bishop_white_black_square.possible_paths)
      black_white_square = extract_path_positions(bishop_black_white_square.possible_paths)
      black_black_square = extract_path_positions(bishop_black_black_square.possible_paths)
      expect(white_white_square).to contain_exactly('g2', 'h3', 'e2', 'd3', 'c4', 'b5', 'a6')
      expect(white_black_square).to contain_exactly('b2', 'a3', 'd2', 'e3', 'f4', 'g5', 'h6')
      expect(black_white_square).to contain_exactly('b7', 'a6', 'd7', 'e6', 'f5', 'g4', 'h3')
      expect(black_black_square).to contain_exactly('g7', 'h6', 'e7', 'd6', 'c5', 'b4', 'a3')
    end
  end
end
