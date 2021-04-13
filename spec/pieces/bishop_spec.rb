# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './lib/pieces/bishop'
require './spec/pieces/linked_list_helper'

describe Bishop do
  subject(:bishop_white_white_square) { described_class.new(WHITE_PIECE, 'f1') }
  subject(:bishop_white_black_square) { described_class.new(WHITE_PIECE, 'c1') }
  subject(:bishop_black_white_square) { described_class.new(BLACK_PIECE, 'c8') }
  subject(:bishop_black_black_square) { described_class.new(BLACK_PIECE, 'f8') }

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
    it "not bishop's first move" do
      bishop_white_white_square.move('h3')
      bishop_white_black_square.move('e3')
      bishop_black_white_square.move('f5')
      bishop_black_black_square.move('a3')
      white_white_square = extract_path_positions(bishop_white_white_square.possible_paths)
      white_black_square = extract_path_positions(bishop_white_black_square.possible_paths)
      black_white_square = extract_path_positions(bishop_black_white_square.possible_paths)
      black_black_square = extract_path_positions(bishop_black_black_square.possible_paths)
      expect(white_white_square).to contain_exactly('g2', 'f1', 'g4', 'f5', 'e6', 'd7', 'c8')
      expect(white_black_square).to contain_exactly('d2', 'c1', 'f2', 'g1', 'd4', 'c5', 'b6', 'a7', 'f4', 'g5', 'h6')
      expect(black_white_square).to contain_exactly('e6', 'd7', 'c8', 'g6', 'h7', 'g4', 'h3', 'e4', 'd3', 'c2', 'b1')
      expect(black_black_square).to contain_exactly('b2', 'c1', 'b4', 'c5', 'd6', 'e7', 'f8')
    end
  end
end

# rubocop:enable Metrics/BlockLength
