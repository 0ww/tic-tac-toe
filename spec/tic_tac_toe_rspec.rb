require_relative '../lib/player.rb'
require_relative '../bin/main.rb'
require_relative '../lib/input_validator_helper.rb'
require_relative '../lib/menu.rb'
require_relative '../lib/game.rb'

describe TicTacToe do
  describe 'Tchek if the board exist' do
    let(:tictactoe) { TicTacToe.new }
    it ' Create an instance variable of the board for the game with element from 1 to 9' do
      expect(tictactoe.instance_variable_get(:@board)).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
    end
  end

  describe 'Tchek if the players exis' do
    let(:players) { Player.new('Certil', 'Simon') }
    it ' Create 2 player an asign a username for each' do
      expect(players.username_one).to eq('Certil')
      expect(players.username_two).to eq('Simon')
    end
  end

  describe '#validate_name' do
    include ValidatorHelper
    let(:validname) { 'Simon' }
    let(:invalidspace) { ' ' }
    let(:invalidempty) { '' }

    it 'player name is valid' do
      expect(validate_name(validname)).to eq(true)
    end

    it 'player name is invalid, space given' do
      expect(validate_name(invalidspace)).to eq(false)
    end

    it 'player name is invalid, empty string given' do
      expect(validate_name(invalidempty)).to eq(false)
    end
  end

  describe 'Display the board' do
    let(:board) { %w[X X X O X O X O X] }
    let(:tictactoe) { TicTacToe.new }
    def capture_output
      old_stdout = $stdout
      $stdout = StringIO.new('', 'w')
      yield
      $stdout.string
    ensure
      $stdout = old_stdout
    end

    let(:output) { capture_output { tictactoe.show_board } }
    it 'print the board for the player' do
      tictactoe.instance_variable_set(:@board, board)
      expect(output).to include(' X | X | X')
      expect(output).to include('-----------')
      expect(output).to include(' O | X | O')
      expect(output).to include('-----------')
      expect(output).to include(' X | O | X')
    end
  end

  describe '#Play' do
    let(:tictactoe) { TicTacToe.new }
    let(:players) { Player.new('Certil', 'Simon') }

    it ' Play the entire game' do
      allow($stdout).to receive(:puts)
      expect(tictactoe).to receive(:gets).and_return('1')
      expect(tictactoe).to receive(:gets).and_return('2')
      expect(tictactoe).to receive(:gets).and_return('3')
      expect(tictactoe).to receive(:gets).and_return('4')
      expect(tictactoe).to receive(:gets).and_return('5')
      expect(tictactoe).to receive(:gets).and_return('6')
      expect(tictactoe).to receive(:gets).and_return('7')

      expect($stdout).to receive(:puts).with("#{players.username_one} is the winner")
      tictactoe.play(players.username_one, players.username_two)
    end
  end

  describe ' Player turn' do
    let(:tictactoe) { TicTacToe.new }
    let(:players) { Player.new('Certil', 'Simon') }
    let(:board) { tictactoe.instance_variable_get(:@board) }
    it 'receives user input via the gets method' do
      allow($stdout).to receive(:puts)
      expect(tictactoe).to receive(:gets).and_return('1')
      tictactoe.turn(board, players.username_one, players.username_two)
    end
  end

  describe '#Winner' do
    let(:tictactoe) { TicTacToe.new }
    let(:players) { Player.new('Certil', 'Simon') }
    let(:moves) { %w[X X X O O 6 7 8 8] }
    it 'congratulates the winner X if his move win' do
      tictactoe.instance_variable_set(:@board, moves)
      expect($stdout).to receive(:puts).with("#{players.username_one} is the winner")
      tictactoe.play(players.username_one, players.username_two)
    end
  end

  describe 'Game Draw' do
    let(:tictactoe) { TicTacToe.new }
    let(:players) { Player.new('Certil', 'Simon') }
    let(:emptyboard) { tictactoe.instance_variable_get(:@board) }

    it 'is is not a draw' do
      expect(tictactoe.game.draw(emptyboard)).to eq(false)
    end

    let(:boardfull) { %w[X O X O X X O X O] }
    let(:board) { tictactoe.instance_variable_set(:@board, boardfull) }

    it 'It is a draw' do
      expect(tictactoe.game.draw(board)).to eq(true)
    end
  end

  describe '#board_full' do
    let(:tictactoe) { TicTacToe.new }
    it 'returns true for a draw' do
      board = %w[X O X O X X O X O]
      tictactoe.instance_variable_set(:@board, board)

      expect(tictactoe.game.logic.board_full(board)).to be_truthy
    end

    it 'returns false for an in-progress Tictacto' do
      board = %w[X 9 X O 9 X 9 X O]
      tictactoe.instance_variable_set(:@board, board)

      expect(tictactoe.game.logic.board_full(board)).to be_falsey
    end
  end
end
