# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './lib/pieces/chess_piece'

describe ChessPiece do
  icon = '♖'
  valid_pos = 'h1'
  valid_coordinate = [7, 7]
  invalid_pos = 'a2'

  subject(:white_piece) { described_class.new(WHITE_PIECE, icon, valid_pos) }

  context 'when instantiating class' do
    context 'sets the correct unicode value' do
      it 'for white pieces' do
        expect(white_piece.unicode).to eql(icon)
      end
      subject { described_class.new(BLACK_PIECE, icon, valid_pos) }
      it 'for black pieces' do
        expect(subject.unicode).to eql('♜')
      end
    end

    it 'sets the team value' do
      expect(white_piece.team).to eql(WHITE_PIECE)
    end

    it 'sets the piece`s starting position' do
      expect(white_piece.coordinate).to eql(valid_coordinate)
    end
    describe '#active?' do
      context 'piece with valid position without promoted flag set' do
        it 'is expected to be active' do
          expect(white_piece).to be_active
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
      white_piece.deactivate
      expect(white_piece).not_to be_active
    end
  end

  describe '#move' do
    context 'for a successful move' do
      it 'updates the coordinate' do
        expect { white_piece.move('h5') }.to change { white_piece.coordinate }.to([3, 7])
      end
    end
  end

  describe '#in_grid?' do
    it 'returns true for coordinate on chessboard' do
      expect(white_piece.in_grid?(valid_pos)).to be true
    end

    context 'coordinates outside chessboard' do
      it 'returns false for shorter strings' do
        expect(white_piece.in_grid?('a')).to be_falsey
      end

      it 'returns false for longer strings' do
        expect(white_piece.in_grid?('A33')).to be_falsey
      end

      it 'returns false for only numbers' do
        expect(white_piece.in_grid?('33')).to be_falsey
      end

      it 'returns false for only letters' do
        expect(white_piece.in_grid?('AA')).to be_falsey
      end

      it 'returns false for letter off the grid' do
        expect(white_piece.in_grid?('J3')).to be_falsey
      end

      it 'returns false for other characters' do
        expect(white_piece.in_grid?('*9')).to be_falsey
      end

      it 'returns false for invalid numbers' do
        expect(white_piece.in_grid?('d0')).to be_falsey
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
