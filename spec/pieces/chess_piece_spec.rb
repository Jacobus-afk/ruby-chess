# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './lib/pieces/chess_piece'

describe ChessPiece do
  icon = '♖'
  valid_pos = 'h1'
  valid_coordinate = [7, 7]
  invalid_pos = 'a2'

  subject(:whitepiece) { described_class.new(WHITE_PIECE, icon, valid_pos) }

  context 'when instantiating class' do
    context 'sets the correct unicode value' do
      it 'for white pieces' do
        expect(whitepiece.unicode).to eql(icon)
      end
      subject { described_class.new(BLACK_PIECE, icon, valid_pos) }
      it 'for black pieces' do
        expect(subject.unicode).to eql('♜')
      end
    end

    it 'sets the team value' do
      expect(whitepiece.team).to eql(WHITE_PIECE)
    end

    it 'sets the first_move flag' do
      expect(whitepiece).to be_first_move
    end

    it 'sets the piece`s starting position' do
      expect(whitepiece.coordinate).to eql(valid_coordinate)
    end
    describe '#active?' do
      context 'piece with valid position without promoted flag set' do
        it 'is expected to be active' do
          expect(whitepiece).to be_active
        end
      end
      context 'piece with with valid position with promoted flag set' do
        subject { described_class.new(WHITE_PIECE, icon, valid_pos, true) }
        it { is_expected.to be_active }
      end
      context 'piece with invalid position without promoted flag set' do
        subject { described_class.new(WHITE_PIECE, icon, invalid_pos) }
        it { is_expected.not_to be_active }
      end
      context 'piece with invalid position with promoted flag set' do
        subject { described_class.new(WHITE_PIECE, icon, invalid_pos, true) }
        it { is_expected.to be_active }
      end
    end
  end

  describe '#deactivate' do
    it 'marks piece as inactive' do
      whitepiece.deactivate
      expect(whitepiece).not_to be_active
    end
  end

  describe '#move' do
    context 'for a successful move' do
      it 'updates the coordinate' do
        expect { whitepiece.move('h5') }.to change { whitepiece.coordinate }.to([3, 7])
      end
      it 'clears the first_move flag' do
        whitepiece.move('h4')
        expect(whitepiece).not_to be_first_move
      end
    end
  end

  describe '#find_position' do
    it 'returns a correct position for a valid coordinate on board' do
      expect(whitepiece.find_position(valid_coordinate)).to eql('h1')
    end

    context 'coordinates not on board' do
      it 'returns nil for shorter coordinates' do
        expect(whitepiece.find_position([0])).to eql nil
      end
      it 'returns nil for non arrays' do
        expect(whitepiece.find_position(77)).to eql nil
      end
      it 'returns nil for coordinates longer than one character' do
        expect(whitepiece.find_position([77, 7])).to eql nil
      end
      it 'returns nil for longer coordinates' do
        expect(whitepiece.find_position([77, 57, 12_345])).to eql nil
      end
      it 'returns nil for coordinates outside board' do
        expect(whitepiece.find_position([8, 0])).to eql nil
      end
      it 'returns nil for negative numbers' do
        expect(whitepiece.find_position([-1, 0])).to eql nil
      end
    end
  end

  # describe '#in_grid?' do
  #   it 'returns true for coordinate on chessboard' do
  #     expect(whitepiece.in_grid?(valid_pos)).to be true
  #   end

  #   context 'coordinates outside chessboard' do
  #     it 'returns false for shorter strings' do
  #       expect(whitepiece.in_grid?('a')).to be_falsey
  #     end

  #     it 'returns false for longer strings' do
  #       expect(whitepiece.in_grid?('A33')).to be_falsey
  #     end

  #     it 'returns false for only numbers' do
  #       expect(whitepiece.in_grid?('33')).to be_falsey
  #     end

  #     it 'returns false for only letters' do
  #       expect(whitepiece.in_grid?('AA')).to be_falsey
  #     end

  #     it 'returns false for letter off the grid' do
  #       expect(whitepiece.in_grid?('J3')).to be_falsey
  #     end

  #     it 'returns false for other characters' do
  #       expect(whitepiece.in_grid?('*9')).to be_falsey
  #     end

  #     it 'returns false for invalid numbers' do
  #       expect(whitepiece.in_grid?('d0')).to be_falsey
  #     end
  #   end
  # end
end

# rubocop:enable Metrics/BlockLength
