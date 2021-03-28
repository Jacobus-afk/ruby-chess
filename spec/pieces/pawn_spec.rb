# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './lib/pieces/pawn'

describe Pawn do
  subject(:pawn_centre) { described_class.new(BLACK_PIECE, 'c7') }
  subject(:pawn_left) { described_class.new(BLACK_PIECE, 'a7') }
  subject(:pawn_right) { described_class.new(WHITE_PIECE, 'h2') }
  context 'when instantiating class' do
  end

  describe '#find_possible_moves' do
    context 'pawn doing its first move' do
      it 'in centre of board' do
        expect(pawn_centre.find_possible_moves).to contain_exactly('c6', 'b6', 'c5', 'd6')
      end
      it 'on left side of board' do
        expect(pawn_left.find_possible_moves).to contain_exactly('b6', 'a6', 'a5')
      end
      it 'on right side of board' do
        expect(pawn_right.find_possible_moves).to contain_exactly('h3', 'h4', 'g3')
      end
    end
    context "not pawn's first move" do
      it 'in center of board' do
        pawn_centre.move('c6')
        expect(pawn_centre.find_possible_moves).to contain_exactly('b5', 'd5', 'c5')
      end
      it 'on left side of board' do
        pawn_left.move('a6')
        expect(pawn_left.find_possible_moves).to contain_exactly('a5', 'b5')
      end
      it 'on right side of board' do
        pawn_right.move('h3')
        expect(pawn_right.find_possible_moves).to contain_exactly('g4', 'h4')
      end
    end

  end
  describe "#check_for_en_passant" do

  end

  describe "#en_passant?" do
    
  end

  describe "#check_for_promotion" do

  end
end

# rubocop:enable Metrics/BlockLength
