# frozen_string_literal: true

require './lib/game'

describe Game do
  subject(:game) { described_class.new }

  context 'when instantiating class' do
    it 'valid_move is false' do
      expect(game.instance_variable_get(:@valid_move)).to be false
    end
    it 'adds a board class instance' do
      expect(game.instance_variable_get(:@board)).to be_a(Board)
    end
  end

  describe '#handle_player_input' do
    before(:each) do
      allow(game).to receive(:loop).and_yield.and_yield.and_yield
    end

    it 'breaks the loop when valid input is made' do
      allow(game).to receive(:read_single_key).and_return(:escape)
      expect(game).to receive(:read_single_key).once
      game.handle_player_input
    end

    it 'loops until a valid input is given' do
      allow(game).to receive(:read_single_key).and_return(nil, nil, nil)
      expect(game).to receive(:read_single_key).exactly(3).times
      game.handle_player_input
    end
  end
end
