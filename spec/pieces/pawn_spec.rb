# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './lib/pieces/pawn'
require './spec/pieces/linked_list_helper'

# RSpec.configure do |config|
#   config.include LinkedListHelper
# end

describe Pawn do
  subject(:pawn_centre) { described_class.new(BLACK_PIECE, 'c7') }
  subject(:pawn_left) { described_class.new(BLACK_PIECE, 'a7') }
  subject(:pawn_right) { described_class.new(WHITE_PIECE, 'h2') }

  context 'when instantiating class' do
    it 'promoted set to false' do
      expect(pawn_centre).not_to be_promoted
      expect(pawn_left).not_to be_promoted
      expect(pawn_right).not_to be_promoted
    end
    it 'en_passant set to false' do
      expect(pawn_centre).not_to be_en_passant
      expect(pawn_left).not_to be_en_passant
      expect(pawn_right).not_to be_en_passant
    end
  end

  context 'for class functions' do
    before(:each) do
      pawn_centre.generate_possible_moves
      pawn_left.generate_possible_moves
      pawn_right.generate_possible_moves
    end
    describe '#generate_possible_moves' do
      context 'pawn doing its first move' do
        it 'in centre of board' do
          possible_positions = extract_path_positions(pawn_centre.possible_paths)
          expect(possible_positions).to contain_exactly('c6', 'b6', 'c5', 'd6')
        end
        it 'on left side of board' do
          possible_positions = extract_path_positions(pawn_left.possible_paths)
          expect(possible_positions).to contain_exactly('b6', 'a6', 'a5')
        end
        it 'on right side of board' do
          possible_positions = extract_path_positions(pawn_right.possible_paths)
          expect(possible_positions).to contain_exactly('h3', 'h4', 'g3')
        end
      end
      context "not pawn's first move" do
        it 'in center of board' do
          pawn_centre.move('c6')
          pawn_centre.generate_possible_moves
          possible_positions = extract_path_positions(pawn_centre.possible_paths)
          expect(possible_positions).to contain_exactly('b5', 'd5', 'c5')
        end
        it 'on left side of board' do
          pawn_left.move('a6')
          pawn_left.generate_possible_moves
          possible_positions = extract_path_positions(pawn_left.possible_paths)
          expect(possible_positions).to contain_exactly('a5', 'b5')
        end
        it 'on right side of board' do
          pawn_right.move('h3')
          pawn_right.generate_possible_moves
          possible_positions = extract_path_positions(pawn_right.possible_paths)
          expect(possible_positions).to contain_exactly('g4', 'h4')
        end
      end
    end

    describe '#en_passant?' do
      context 'for first move' do
        context 'en_passant flag is set after moving two spaces' do
          it 'for black pieces' do
            pawn_centre.move('c5')
            expect(pawn_centre).to be_en_passant
          end
          it 'for white pieces' do
            pawn_right.move('h4')
            expect(pawn_right).to be_en_passant
          end
        end
        context 'en_passant flag is not set set after moving one space' do
          it 'for black pieces' do
            pawn_centre.move('c6')
            expect(pawn_centre).not_to be_en_passant
          end
          it 'for white pieces' do
            pawn_right.move('h3')
            expect(pawn_right).not_to be_en_passant
          end
        end
      end
      context 'for second move' do
        context 'en_passant flag is not set after moving three spaces' do
          it 'for black pieces' do
            pawn_left.move('a5')
            pawn_left.move('a4')
            expect(pawn_left).not_to be_en_passant
          end
          it 'for white pieces' do
            pawn_right.move('h4')
            pawn_right.move('h5')
            expect(pawn_right).not_to be_en_passant
          end
        end
        context 'en_passant flag is not set after moving two spaces' do
          it 'for black pieces' do
            pawn_left.move('a6')
            pawn_left.move('a5')
            expect(pawn_left).not_to be_en_passant
          end
          it 'for white pieces' do
            pawn_right.move('h3')
            pawn_right.move('h4')
            expect(pawn_right).not_to be_en_passant
          end
        end
      end
    end

    describe '#promoted?' do
      let(:node) { instance_double('Node') }
      before(:each) do
        pawn_centre.possible_paths.append(node)
        pawn_left.possible_paths.append(node)
        pawn_right.possible_paths.append(node)
      end
      context 'pawn moved to last row' do
        it 'in center of board' do
          allow(node).to receive(:find).and_return('a true value')
          pawn_centre.move('c1')
          expect(pawn_centre).to be_promoted
        end
        it 'on left side of board' do
          allow(node).to receive(:find).and_return('a true value')
          pawn_left.move('a1')
          expect(pawn_left).to be_promoted
        end
        it 'on right side of board' do
          allow(node).to receive(:find).and_return('a true value')
          pawn_right.move('h8')
          expect(pawn_right).to be_promoted
        end
      end
      context 'pawn moved to any other row' do
        context 'in center of board' do
          %w[c2 c3 c4 c5 c6 c7].each do |move|
            it "checks whether move to #{move} causes a promotion" do
              allow(node).to receive(:find).and_return('a true value')
              pawn_centre.move(move)
              expect(pawn_centre).not_to be_promoted
            end
          end
        end
        context 'on left side of board' do
          %w[a2 a3 a4 a5 a6 a7].each do |move|
            it "checks whether move to #{move} causes a promotion" do
              allow(node).to receive(:find).and_return('a true value')
              pawn_left.move(move)
              expect(pawn_left).not_to be_promoted
            end
          end
        end
        context 'on right side of board' do
          %w[h2 h3 h4 h5 h6 h7].each do |move|
            it "checks whether move to #{move} causes a promotion" do
              allow(node).to receive(:find).and_return('a true value')
              pawn_right.move(move)
              expect(pawn_right).not_to be_promoted
            end
          end
        end
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
