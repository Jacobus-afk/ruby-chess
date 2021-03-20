# frozen_string_literal: true

require './lib/pieces/chess_piece'

describe ChessPiece do
  context 'when instantiating class' do
    ucode = '♜'
    subject(:piece) { described_class.new(ucode) }
    it 'sets the unicode value' do
      expect(piece.unicode).to eql(ucode)
    end
  end
end
