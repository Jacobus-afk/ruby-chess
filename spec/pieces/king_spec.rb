# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './lib/pieces/king'
require './spec/pieces/linked_list_helper'

describe King do
  subject(:white_king) { described_class.new(WHITE_PIECE, 'e1') }
  subject(:black_king) { described_class.new(BLACK_PIECE, 'e8') }

  context 'when instantiating class' do
    it 'castled is set to false' do
      expect(white_king).not_to be_castling
      expect(black_king).not_to be_castling
    end
  end
  context 'for class functions' do
    before(:each) do
      white_king.generate_possible_moves
      black_king.generate_possible_moves
    end
    describe '#generate_possible_moves' do
      it "king's first move" do
        white_positions = extract_path_positions(white_king.possible_paths)
        black_positions = extract_path_positions(black_king.possible_paths)
        expect(white_positions).to contain_exactly('d1', 'c1', 'f1', 'g1', 'd2', 'e2', 'f2')
        expect(black_positions).to contain_exactly('d8', 'c8', 'f8', 'g8', 'd7', 'e7', 'f7')
      end
      it "not king's first move" do
        white_king.move('e2')
        black_king.move('e7')
        white_king.generate_possible_moves
        black_king.generate_possible_moves
        white_positions = extract_path_positions(white_king.possible_paths)
        black_positions = extract_path_positions(black_king.possible_paths)
        expect(white_positions).to contain_exactly('d1', 'e1', 'f1', 'd2', 'f2', 'd3', 'e3', 'f3')
        expect(black_positions).to contain_exactly('d8', 'e8', 'f8', 'd7', 'f7', 'd6', 'e6', 'f6')
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
