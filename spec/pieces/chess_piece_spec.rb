# frozen_string_literal: true

require './lib/pieces/chess_piece'

describe ChessPiece do
  ucode = '♜'
  pos = 'a1'
  team = 0
  subject(:piece) { described_class.new(team, ucode, pos) }
  context 'when instantiating class' do
    it 'sets the team value' do
      expect(piece.team).to eql(team)
    end
    it 'sets the unicode value' do
      expect(piece.unicode).to eql(ucode)
    end
    it 'sets the piece`s starting position' do
      expect(piece.position).to eql(pos)
    end
    it 'verifies that piece is active' do
      expect(piece).to be_active
    end
  end

  describe '#deactivate' do
    it 'marks piece as inactive' do
      piece.deactivate
      expect(piece).not_to be_active
    end
  end
end
