# frozen_string_literal: true

require './lib/pieces/king'

describe King do
  context 'when instantiating class' do
    subject(:white_king) { described_class.new(WHITE_PIECE, 'e1') }
    subject(:black_king) { described_class.new(BLACK_PIECE, 'e8') }
    it 'castled is set to false' do
      expect(white_king).not_to be_castling
      expect(black_king).not_to be_castling
    end
  end
end
