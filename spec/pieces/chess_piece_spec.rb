# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './lib/pieces/chess_piece'

describe Node do
  data = { 'a1' => %i[check_move check_attack] }
  new_data = { 'a2' => %i[check_move] }
  more_data = { 'a3' => %i[check_enpassant] }
  subject(:node) { described_class.new(data) }
  subject(:new_node) { described_class.new(new_data) }
  subject(:another_node) { described_class.new(more_data) }
  context 'when instantiating class' do
    it 'initializes next pointer to nil' do
      expect(node.next).to be nil
    end
    it 'stores data correctly' do
      expect(node.data).to eql(data)
    end
  end
  context 'for class functions' do
    before(:each) do
      node.append(new_node)
      node.append(another_node)
    end
    describe '#append' do
      it 'adds new nodes correctly' do
        expect(node.next).to eql(new_node)
        expect(new_node.next).to eql(another_node)
      end
    end
    describe '#find' do
      it 'returns the node data if the data key is in the linked list' do
        expect(node.find('a3')).to eql(more_data)
      end
      it 'returns nil if data key is not in linked list' do
        expect(node.find('a4')).to be nil
      end
    end
  end
end

describe ChessPiece do
  icon = '♖'
  valid_start_pos = 'h1'
  valid_coordinate = [7, 7]
  invalid_start_pos = 'a2'

  subject(:whitepiece) { described_class.new(WHITE_PIECE, icon, valid_start_pos) }
  subject(:node) { instance_double(Node) }

  context 'when instantiating class' do
    context 'sets the correct unicode value' do
      it 'for white pieces' do
        expect(whitepiece.unicode).to eql(icon)
      end
      subject { described_class.new(BLACK_PIECE, icon, valid_start_pos) }
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
      context 'piece with valid starting position without promoted flag set' do
        it 'is expected to be active' do
          expect(whitepiece).to be_active
        end
      end
      context 'piece with with valid starting position with promoted flag set' do
        subject { described_class.new(WHITE_PIECE, icon, valid_start_pos, true) }
        it { is_expected.to be_active }
      end
      context 'piece with invalid starting position without promoted flag set' do
        subject { described_class.new(WHITE_PIECE, icon, invalid_start_pos) }
        it { is_expected.not_to be_active }
      end
      context 'piece with invalid starting position with promoted flag set' do
        subject { described_class.new(WHITE_PIECE, icon, invalid_start_pos, true) }
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
    before(:each) do
      whitepiece.possible_paths.append(node)
    end
    context 'for a successful move' do
      it 'updates the coordinate and clears first_move flag' do
        allow(node).to receive(:find).and_return('a true value')
        expect { whitepiece.move('h5') }.to change { whitepiece.coordinate }.to([3, 7])
        expect(whitepiece).not_to be_first_move
      end
    end
    context 'for an unsuccesful move' do
      it 'leaves the coordinate and first_move flag as is' do
        allow(node).to receive(:find).and_return(nil)
        expect { whitepiece.move('h4') }.not_to change(whitepiece, :coordinate)
        expect(whitepiece).to be_first_move
      end
    end
  end

  describe '#find_position' do
    it 'returns a correct position for a valid coordinate on board' do
      expect(whitepiece.find_position([3, 4])).to eql('e5')
      expect(whitepiece.find_position([5, 7])).to eql('h3')
    end

    context 'returns nil for invalid coordinates' do
      it 'shorter coordinates' do
        expect(whitepiece.find_position([0])).to eql nil
        expect(whitepiece.find_position([])).to eql nil
      end
      it 'longer coordinates' do
        expect(whitepiece.find_position([77, 57, 12_345])).to eql nil
        expect(whitepiece.find_position([1, 2, 3, 4])).to eql nil
      end
      it 'non arrays' do
        expect(whitepiece.find_position(77)).to eql nil
      end
      it 'coordinates outside board' do
        expect(whitepiece.find_position([8, 0])).to eql nil
        expect(whitepiece.find_position([1, 9])).to eql nil
        expect(whitepiece.find_position([77, 7])).to eql nil
        expect(whitepiece.find_position([7, 33])).to eql nil
      end
      it 'negative numbers' do
        expect(whitepiece.find_position([-1, 0])).to eql nil
        expect(whitepiece.find_position([7, -3])).to eql nil
      end
    end
  end

  describe '#find_coordinate' do
    it 'returns correct coordinate for valid position' do
      expect(whitepiece.find_coordinate('a1')).to eql [7, 0]
      expect(whitepiece.find_coordinate('h8')).to eql [0, 7]
    end
    context 'returns nil for invalid positions' do
      it 'shorter positions' do
        expect(whitepiece.find_coordinate('a')).to eql nil
      end
      it 'longer positions' do
        expect(whitepiece.find_coordinate('f33')).to eql nil
        expect(whitepiece.find_coordinate('gh3')).to eql nil
      end
      it 'non alphanumeric string' do
        expect(whitepiece.find_coordinate('*&')).to eql nil
        expect(whitepiece.find_coordinate('ab')).to eql nil
        expect(whitepiece.find_coordinate('11')).to eql nil
        expect(whitepiece.find_coordinate(11)).to eql nil
      end
      it 'positions outside board' do
        expect(whitepiece.find_coordinate('i1')).to eql nil
        expect(whitepiece.find_coordinate('h0')).to eql nil
        expect(whitepiece.find_coordinate('d9')).to eql nil
      end
    end
  end

  describe '#generate_possible_moves' do
    it 'clears the possible_paths array when invoked' do
      whitepiece.possible_paths.append(node)
      expect { whitepiece.generate_possible_moves }.to change { whitepiece.possible_paths }.from([node]).to([])
    end
  end
end

# rubocop:enable Metrics/BlockLength
