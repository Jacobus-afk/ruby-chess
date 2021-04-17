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
    describe '#generate_possible_moves' do
      let(:node) { instance_double(Node) }
      it "king's first move" do
        white_positions = extract_path_positions(white_king.possible_paths)
        black_positions = extract_path_positions(black_king.possible_paths)
        expect(white_positions).to contain_exactly('e1', 'e1', 'e1', 'e1', 'e1', 'e1', 'e1',
                                                   'd1', 'c1', 'f1', 'g1', 'd2', 'e2', 'f2')
        expect(black_positions).to contain_exactly('e8', 'e8', 'e8', 'e8', 'e8', 'e8', 'e8',
                                                   'd8', 'c8', 'f8', 'g8', 'd7', 'e7', 'f7')
      end
      it "not king's first move" do
        white_king.move('e2')
        black_king.move('e7')
        white_positions = extract_path_positions(white_king.possible_paths)
        black_positions = extract_path_positions(black_king.possible_paths)
        expect(white_positions).to contain_exactly('e2', 'e2', 'e2', 'e2', 'e2', 'e2', 'e2', 'e2',
                                                   'd1', 'e1', 'f1', 'd2', 'f2', 'd3', 'e3', 'f3')
        expect(black_positions).to contain_exactly('e7', 'e7', 'e7', 'e7', 'e7', 'e7', 'e7', 'e7',
                                                   'd8', 'e8', 'f8', 'd7', 'f7', 'd6', 'e6', 'f6')
      end
      it 'edge cases' do
        white_king.possible_paths.append(node)
        black_king.possible_paths.append(node)
        allow(node).to receive(:find).and_return('a valid value').twice
        white_king.move('h8')
        black_king.move('a1')
        white_positions = extract_path_positions(white_king.possible_paths)
        black_positions = extract_path_positions(black_king.possible_paths)
        expect(white_positions).to contain_exactly('h8', 'h8', 'h8', 'g8', 'g7', 'h7')
        expect(black_positions).to contain_exactly('a1', 'a1', 'a1', 'a2', 'b2', 'b1')
      end
    end

    describe '#castling?' do
      context 'for double first move' do
        before(:each) do
          white_king.move('g1')
          black_king.move('c8')
        end
        it 'castling flag is set' do
          expect(white_king).to be_castling
          expect(black_king).to be_castling
        end
        it 'castling flag is reset after next move' do
          white_king.move('g2')
          black_king.move('b8')
          expect(white_king).not_to be_castling
          expect(black_king).not_to be_castling
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
