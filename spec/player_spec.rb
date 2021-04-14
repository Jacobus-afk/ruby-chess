# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './lib/player.rb'

describe Player do
  pos_white = 'a3'
  coord_white = [5, 0]
  pos_black = 'h6'
  coord_black = [2, 7]
  subject(:player_white) { described_class.new(WHITE_PIECE, pos_white) }
  subject(:player_black) { described_class.new(BLACK_PIECE, pos_black) }

  context 'when instantiating class' do
    it 'sets team correctly' do
      expect(player_white.team).to eql(WHITE_PIECE)
      expect(player_black.team).to eql(BLACK_PIECE)
    end
    it 'sets active correctly' do
      expect(player_white.active).to eql true
      expect(player_black.active).to eql false
    end
    it "sets the player's starting coordinate" do
      expect(player_white.coordinate).to eql(coord_white)
      expect(player_black.coordinate).to eql(coord_black)
    end
  end

  describe '#move_left' do
    it 'updates the coordinate and position for a valid move' do
      player_black.move_left
      expect(player_black.coordinate).to eql([2, 6])
      expect(player_black.instance_variable_get(:@position)).to eql('g6')
    end
    it "doesn't update the coordinate and position for an invalid move" do
      player_white.move_left
      expect(player_white.coordinate).to eql(coord_white)
      expect(player_white.instance_variable_get(:@position)).to eql(pos_white)
    end
  end
end

# rubocop:enable Metrics/BlockLength
