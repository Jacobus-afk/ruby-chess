# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './lib/pieces/knight'
require './spec/pieces/linked_list_helper'

describe Knight do
  subject(:knight_white_white_square) { described_class.new(WHITE_PIECE, 'b1') }
  subject(:knight_white_black_square) { described_class.new(WHITE_PIECE, 'g1') }
  subject(:knight_black_white_square) { described_class.new(BLACK_PIECE, 'g8') }
  subject(:knight_black_black_square) { described_class.new(BLACK_PIECE, 'b8') }

  describe '#generate_possible_moves' do
    it "knight's first move" do
      white_white_square = extract_path_positions(knight_white_white_square.possible_paths)
      white_black_square = extract_path_positions(knight_white_black_square.possible_paths)
      black_white_square = extract_path_positions(knight_black_white_square.possible_paths)
      black_black_square = extract_path_positions(knight_black_black_square.possible_paths)
      expect(white_white_square).to contain_exactly('b1', 'b1', 'b1', 'a3', 'c3', 'd2')
      expect(white_black_square).to contain_exactly('g1', 'g1', 'g1', 'h3', 'f3', 'e2')
      expect(black_white_square).to contain_exactly('g8', 'g8', 'g8', 'h6', 'f6', 'e7')
      expect(black_black_square).to contain_exactly('b8', 'b8', 'b8', 'a6', 'c6', 'd7')
    end
    it "not knight's first move" do
      knight_white_white_square.move('c3')
      knight_white_black_square.move('h3')
      knight_black_white_square.move('e7')
      knight_black_black_square.move('a6')
      white_white_square = extract_path_positions(knight_white_white_square.possible_paths)
      white_black_square = extract_path_positions(knight_white_black_square.possible_paths)
      black_white_square = extract_path_positions(knight_black_white_square.possible_paths)
      black_black_square = extract_path_positions(knight_black_black_square.possible_paths)
      expect(white_white_square).to contain_exactly('c3', 'c3', 'c3', 'c3', 'c3', 'c3', 'c3', 'c3',
                                                    'b1', 'a2', 'a4', 'b5', 'd5', 'e4', 'e2', 'd1')
      expect(white_black_square).to contain_exactly('h3', 'h3', 'h3', 'h3', 'g1', 'f2', 'f4', 'g5')
      expect(black_white_square).to contain_exactly('e7', 'e7', 'e7', 'e7', 'e7', 'e7',
                                                    'g8', 'g6', 'f5', 'd5', 'c6', 'c8')
      expect(black_black_square).to contain_exactly('a6', 'a6', 'a6', 'a6', 'b8', 'c7', 'c5', 'b4')
    end
  end
end
# rubocop:enable Metrics/BlockLength
