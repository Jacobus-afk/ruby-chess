# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './lib/pieces/chess_piece'

describe ChessPiece do
  ucode = '♖'
  pos = 'a1'
  team = WHITE_PIECE
  subject(:white_piece) { described_class.new(team, ucode, pos) }
  context 'when instantiating class' do
    context 'for white pieces' do
      it 'sets the team value' do
        expect(white_piece.team).to eql(team)
      end
      it 'sets the unicode value' do
        expect(white_piece.unicode).to eql(ucode)
      end
      it 'sets the piece`s starting position' do
        expect(white_piece.position).to eql(pos)
      end
      it 'verifies that piece is active' do
        expect(white_piece).to be_active
      end
    end
    context 'for black pieces' do
      subject(:black_piece) { described_class.new(BLACK_PIECE, ucode, pos) }
      it 'sets the correct unicode value' do
        expect(black_piece.unicode).to eql('♜')
      end
    end
  end

  describe '#deactivate' do
    it 'marks piece as inactive' do
      white_piece.deactivate
      expect(white_piece).not_to be_active
    end
  end
end

# rubocop:enable Metrics/BlockLength
