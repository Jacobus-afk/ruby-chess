# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './lib/pieces/queen'
require './spec/pieces/linked_list_helper'

describe Queen do
  subject(:queen_white) { described_class.new(WHITE_PIECE, 'd1') }
  subject(:queen_black) { described_class.new(BLACK_PIECE, 'd8') }

  describe '#generate_possible_moves' do
    it "queen's first move" do
      positions_white = extract_path_positions(queen_white.possible_paths)
      positions_black = extract_path_positions(queen_black.possible_paths)
      expect(positions_white).to contain_exactly('d1', 'd2', 'd3', 'd4', 'd5', 'd6', 'd7', 'd8',
                                                 'd1', 'd1', 'c2', 'b3', 'a4',
                                                 'd1', 'e2', 'f3', 'g4', 'h5',
                                                 'd1', 'a1', 'b1', 'c1', 'e1', 'f1', 'g1', 'h1')
      expect(positions_black).to contain_exactly('d8', 'd7', 'd6', 'd5', 'd4', 'd3', 'd2', 'd1',
                                                 'd8', 'd8', 'c7', 'b6', 'a5',
                                                 'd8', 'e7', 'f6', 'g5', 'h4',
                                                 'd8', 'a8', 'b8', 'c8', 'e8', 'f8', 'g8', 'h8')
    end
    it "not queen's first move" do
      queen_white.move('d4')
      queen_black.move('a5')
      positions_white = extract_path_positions(queen_white.possible_paths)
      positions_black = extract_path_positions(queen_black.possible_paths)
      expect(positions_white).to contain_exactly('d4', 'd4', 'd1', 'd2', 'd3', 'd5', 'd6', 'd7', 'd8',
                                                 'd4', 'd4', 'a4', 'b4', 'c4', 'e4', 'f4', 'g4', 'h4',
                                                 'd4', 'd4', 'a1', 'b2', 'c3', 'e5', 'f6', 'g7', 'h8',
                                                 'd4', 'd4', 'a7', 'b6', 'c5', 'e3', 'f2', 'g1')
      expect(positions_black).to contain_exactly('a5', 'a1', 'a2', 'a3', 'a4', 'a6', 'a7', 'a8',
                                                 'a5', 'b5', 'c5', 'd5', 'e5', 'f5', 'g5', 'h5',
                                                 'a5', 'a5', 'b6', 'c7', 'd8',
                                                 'a5', 'b4', 'c3', 'd2', 'e1')
    end
  end
end

# rubocop:enable Metrics/BlockLength
