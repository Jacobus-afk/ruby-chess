# frozen_string_literal: true

require './lib/pieces/rook'
require './spec/pieces/linked_list_helper'

describe Rook do
  subject(:rook_white_white_square) { described_class.new(WHITE_PIECE, 'h1') }
  subject(:rook_white_black_square) { described_class.new(WHITE_PIECE, 'a1') }
  subject(:rook_black_white_square) { described_class.new(BLACK_PIECE, 'a8') }
  subject(:rook_black_black_square) { described_class.new(BLACK_PIECE, 'h8') }

  describe '#generate_possible_moves' do
    let(:node) { instance_double(Node) }
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
    it "not rook's first move" do
      rook_white_black_square.possible_paths.append(node)
      rook_black_white_square.possible_paths.append(node)
      allow(node).to receive(:find).and_return('a valid value').twice
      rook_white_white_square.move('e1')
      rook_white_black_square.move('c4')
      rook_black_white_square.move('e5')
      rook_black_black_square.move('h5')
      white_white_square = extract_path_positions(rook_white_white_square.possible_paths)
      white_black_square = extract_path_positions(rook_white_black_square.possible_paths)
      black_white_square = extract_path_positions(rook_black_white_square.possible_paths)
      black_black_square = extract_path_positions(rook_black_black_square.possible_paths)
      expect(white_white_square).to contain_exactly('a1', 'b1', 'c1', 'd1', 'f1', 'g1', 'h1',
                                                    'e2', 'e3', 'e4', 'e5', 'e6', 'e7', 'e8')
      expect(white_black_square).to contain_exactly('a4', 'b4', 'd4', 'e4', 'f4', 'g4', 'h4',
                                                    'c1', 'c2', 'c3', 'c5', 'c6', 'c7', 'c8')
      expect(black_white_square).to contain_exactly('a5', 'b5', 'c5', 'd5', 'f5', 'g5', 'h5',
                                                    'e1', 'e2', 'e3', 'e4', 'e6', 'e7', 'e8')
      expect(black_black_square).to contain_exactly('a5', 'b5', 'c5', 'd5', 'e5', 'f5', 'g5',
                                                    'h1', 'h2', 'h3', 'h4', 'h6', 'h7', 'h8')
    end
  end
end
