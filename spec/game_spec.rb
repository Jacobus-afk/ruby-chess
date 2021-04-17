# frozen_string_literal: true

require './lib/game'

describe Game do
  subject(:game) { described_class.new }

  describe '#player_input' do
    before(:each) do
      allow(game).to receive(:loop).and_yield.and_yield.and_yield
    end

    it 'breaks the loop when valid input is made' do
      allow(game).to receive(:read_single_key).and_return(:escape)
      expect(game).to receive(:read_single_key).once
      game.player_input
    end

    it 'loops until a valid input is given' do
      allow(game).to receive(:read_single_key).and_return(nil, nil, nil)
      expect(game).to receive(:read_single_key).exactly(3).times
      game.player_input
    end
  end
end
