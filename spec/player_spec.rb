# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './lib/player.rb'

describe Player do
  pos_white = 'a1'
  coord_white = [7, 0]
  pos_black = 'h8'
  coord_black = [0, 7]
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
      expect(player_black.coordinate).to eql([0, 6])
      expect(player_black.instance_variable_get(:@position)).to eql('g8')
    end
    it "doesn't update the coordinate and position for an invalid move" do
      player_white.move_left
      expect(player_white.coordinate).to eql(coord_white)
      expect(player_white.instance_variable_get(:@position)).to eql(pos_white)
    end
  end

  describe '#move_right' do
    it 'updates the coordinate and position for a valid move' do
      player_white.move_right
      expect(player_white.coordinate).to eql([7, 1])
      expect(player_white.instance_variable_get(:@position)).to eql('b1')
    end
    it "doesn't update the coordinate and position for an invalid move" do
      player_black.move_right
      expect(player_black.coordinate).to eql(coord_black)
      expect(player_black.instance_variable_get(:@position)).to eql(pos_black)
    end
  end

  describe '#move_down' do
    it 'updates the coordinate and position for a valid move' do
      player_black.move_down
      expect(player_black.coordinate).to eql([1, 7])
      expect(player_black.instance_variable_get(:@position)).to eql('h7')
    end
    it "doesn't update the coordinate and position for an invalid move" do
      player_white.move_down
      expect(player_white.coordinate).to eql(coord_white)
      expect(player_white.instance_variable_get(:@position)).to eql(pos_white)
    end
  end

  describe '#move_up' do
    it 'updates the coordinate and position for a valid move' do
      player_white.move_up
      expect(player_white.coordinate).to eql([6, 0])
      expect(player_white.instance_variable_get(:@position)).to eql('a2')
    end
    it "doesn't update the coordinate and position for an invalid move" do
      player_black.move_up
      expect(player_black.coordinate).to eql(coord_black)
      expect(player_black.instance_variable_get(:@position)).to eql(pos_black)
    end
  end
end

# rubocop:enable Metrics/BlockLength
