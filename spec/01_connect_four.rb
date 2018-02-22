require_relative '../lib/connect_four.rb'

describe './lib/connect_four.rb' do
  describe ConnectFour do
    describe '#initialize' do
      it 'assigns an instance variable @board to an array with 6 arrays of 7 unfilled spots' do
          # 0 = an empty spot; 1 = player 1 (red); 2 = player 2 (blue)
          # board[0][0] is the top left cell board[0][1] is the cell to its right
          # board[row][column]
        game = ConnectFour.new
        expect(game.instance_variable_get(:@board)).to eq(
          [
            [0,0,0,0,0,0,0], 
            [0,0,0,0,0,0,0], 
            [0,0,0,0,0,0,0], 
            [0,0,0,0,0,0,0], 
            [0,0,0,0,0,0,0], 
            [0,0,0,0,0,0,0]
          ]
        )
      end
    end

    describe '#colorize' do
      it "accepts the user's input (a color code and a string) as an argument" do
        game = ConnectFour.new
        expect{game.colorize}.to raise_error(ArgumentError)
        expect{game.colorize("34")}.to raise_error(ArgumentError)
        expect{game.colorize('a string')}.to raise_error(ArgumentError)
      end
    
      it "colors the text of the input string with the color code of the color" do
        game = ConnectFour.new
        expect(game.colorize("text", "1")).to eq("\e[1mtext\e[0m")
        expect(game.colorize("other text", "34")).to eq("\e[34mother text\e[0m")
        expect(game.colorize(",text,", "55")).to eq("\e[55m,text,\e[0m")
      end
    end

    describe '#display_board' do
      it 'prints an empty board' do
        board = [
          [0,0,0,0,0,0,0], 
          [0,0,0,0,0,0,0], 
          [0,0,0,0,0,0,0], 
          [0,0,0,0,0,0,0], 
          [0,0,0,0,0,0,0], 
          [0,0,0,0,0,0,0]
        ]
        game = ConnectFour.new
        game.instance_variable_set(:@board, board)

        output = capture_puts{ game.display_board }

        expect(output).to include("+---+---+---+---+---+---+---+")
        expect(output).to include("| ● | ● | ● | ● | ● | ● | ● |")
        expect(output).to include("+---+---+---+---+---+---+---+")
        expect(output).to include("| ● | ● | ● | ● | ● | ● | ● |")
        expect(output).to include("+---+---+---+---+---+---+---+")
        expect(output).to include("| ● | ● | ● | ● | ● | ● | ● |")
        expect(output).to include("+---+---+---+---+---+---+---+")
        expect(output).to include("| ● | ● | ● | ● | ● | ● | ● |")
        expect(output).to include("+---+---+---+---+---+---+---+")
        expect(output).to include("| ● | ● | ● | ● | ● | ● | ● |")
        expect(output).to include("+---+---+---+---+---+---+---+")
        expect(output).to include("| ● | ● | ● | ● | ● | ● | ● |")
        expect(output).to include("+---+---+---+---+---+---+---+")
      end
      it 'prints arbitrary arrangements of the board' do
        board = [
          [0,0,0,0,0,0,1], 
          [0,5,0,0,0,1,2], 
          [0,0,0,0,0,2,1], 
          [1,0,0,0,0,1,2], 
          [1,0,0,0,0,2,1], 
          [1,0,2,0,0,2,1]
        ]
        game = ConnectFour.new
        game.instance_variable_set(:@board, board)

        output = capture_puts{ game.display_board }

        expect(output).to include("+---+---+---+---+---+---+---+")
        expect(output).to include("| ● | ● | ● | ● | ● | ● | \e[31m●\e[0m |")
        expect(output).to include("+---+---+---+---+---+---+---+")
        expect(output).to include("| ● | ● | ● | ● | ● | \e[31m●\e[0m | \e[34m●\e[0m |")
        expect(output).to include("+---+---+---+---+---+---+---+")
        expect(output).to include("| ● | ● | ● | ● | ● | \e[34m●\e[0m | \e[31m●\e[0m |")
        expect(output).to include("+---+---+---+---+---+---+---+")
        expect(output).to include("| \e[31m●\e[0m | ● | ● | ● | ● | \e[31m●\e[0m | \e[34m●\e[0m |")
        expect(output).to include("+---+---+---+---+---+---+---+")
        expect(output).to include("| \e[31m●\e[0m | ● | ● | ● | ● | \e[34m●\e[0m | \e[31m●\e[0m |")
        expect(output).to include("+---+---+---+---+---+---+---+")
        expect(output).to include("| \e[31m●\e[0m | ● | ● | ● | ● | \e[34m●\e[0m | \e[31m●\e[0m |")
        expect(output).to include("+---+---+---+---+---+---+---+")
      end
    end

    describe '#input_to_index' do
      it "accepts the user's input (a string) as an argument" do
        game = ConnectFour.new
        expect{game.input_to_index}.to raise_error(ArgumentError)
      end

      it "converts the user's input (a string) into an integer" do
        game = ConnectFour.new
        expect(game.input_to_index("1")).to be_an(Integer)
      end

      it "converts the user's input from the user-friendly format (on a 1-9 scale) to the array-friendly format (where the first index starts at 0)" do
        game = ConnectFour.new
        expect(game.input_to_index("1")).to eq(0)
        expect(game.input_to_index("5")).to eq(4)
      end
    end

    describe '#move' do
      it 'adds peices to the board in the lowest open spot in the specified column' do
        game = ConnectFour.new
        
        game.move(4, 1)
        game.move(4, 2)
        game.move(3, 2)
        game.move(4, 1)
        game.move(4, 2)
        game.move(3, 1)

        board = game.instance_variable_get(:@board)

        expect(board).to eq([
          [0,0,0,0,0,0,0], 
          [0,0,0,0,0,0,0], 
          [0,0,0,0,2,0,0], 
          [0,0,0,0,1,0,0], 
          [0,0,0,1,2,0,0], 
          [0,0,0,2,1,0,0]
        ])
      end      
    end

    describe '#position_taken?' do
      it 'returns true/false based on whether the column on the board is already full' do
        game = ConnectFour.new
        board = [
          [1,0,0,0,1,0,0], 
          [2,0,0,0,1,0,0], 
          [2,0,0,0,2,0,0], 
          [2,0,0,0,1,0,0], 
          [1,0,0,1,2,0,0], 
          [2,0,0,2,1,0,0]
        ]
        game.instance_variable_set(:@board, board)

        index = 0
        expect(game.position_taken?(index)).to be(true)

        index = 4
        expect(game.position_taken?(index)).to be(true)

        index = 1
        expect(game.position_taken?(index)).to be(false)

        index = 6
        expect(game.position_taken?(index)).to be(false)
      end
    end

    describe '#valid_move?' do
      it 'returns true/false based on whether the position is already occupied' do
        game = ConnectFour.new
        board = [
          [1,0,0,0,1,0,0], 
          [2,0,0,0,1,0,0], 
          [2,0,0,0,2,0,0], 
          [2,0,0,0,1,0,0], 
          [1,0,0,1,2,0,0], 
          [2,0,0,2,1,0,0]
        ]
        game.instance_variable_set(:@board, board)

        index = 0
        expect(game.valid_move?(index)).to be_falsey

        index = 4
        expect(game.valid_move?(index)).to be_falsey

        index = 2
        expect(game.valid_move?(index)).to be_truthy

        index = 5
        expect(game.valid_move?(index)).to be_truthy
      end

      it 'checks that the attempted move is within the bounds of the game board' do
        allow_any_instance_of(ConnectFour).to receive(:position_taken?).and_return(false)
        game = ConnectFour.new
        expect(game.valid_move?(99)).to be_falsey
      end
    end

    describe '#turn_count' do
      it 'counts occupied positions' do
        game = ConnectFour.new
        board = [
          [1,0,0,0,1,0,0], 
          [2,0,0,0,1,0,0], 
          [2,0,0,0,2,0,0], 
          [2,0,0,0,1,0,0], 
          [1,0,0,1,2,0,0], 
          [2,0,0,2,1,0,0]
        ]
        game.instance_variable_set(:@board, board)

        expect(game.turn_count).to eq(14)

        board = [
          [0,0,0,0,0,0,0], 
          [0,0,0,0,0,0,0], 
          [0,0,0,0,2,0,0], 
          [2,0,0,0,1,0,0], 
          [1,0,0,1,2,0,0], 
          [2,0,0,2,1,0,0]
        ]
        game.instance_variable_set(:@board, board)

        expect(game.turn_count).to eq(9)
      end
    end

    describe '#current_player' do
      it 'returns the correct player, 1, for the third move' do
        game = ConnectFour.new
        board = [
          [0,0,0,0,0,0,0], 
          [0,0,0,0,0,0,0], 
          [0,0,0,0,0,0,0], 
          [0,0,0,0,0,0,0], 
          [0,0,0,1,0,0,0], 
          [0,0,0,2,1,0,0]
        ]
        game.instance_variable_set(:@board, board)

        expect(game.current_player).to eq(2)
      end

      it 'returns the correct player, 2, for the fourth move' do
        game = ConnectFour.new
        board = [
          [0,0,0,0,0,0,0], 
          [0,0,0,0,0,0,0], 
          [0,0,0,0,0,0,0], 
          [0,0,0,0,0,0,0], 
          [0,0,0,1,0,0,0], 
          [0,0,2,2,1,0,0]
        ]
        game.instance_variable_set(:@board, board)

        expect(game.current_player).to eq(1)
      end
    end

    # describe '#turn' do
    #   let(:game) { ConnectFour.new }

    #   it 'receives user input via the gets method' do
    #     allow($stdout).to receive(:puts)
    #     expect(game).to receive(:gets).and_return("1")

    #     game.turn
    #   end

    #   it "calls #input_to_index, #valid_move?, and #current_player" do
    #     allow($stdout).to receive(:puts)
    #     expect(game).to receive(:gets).and_return("5")
    #     expect(game).to receive(:input_to_index).and_return(4)
    #     expect(game).to receive(:valid_move?).and_return(true)
    #     expect(game).to receive(:current_player).and_return("X")

    #     game.turn
    #   end

    #   it 'makes valid moves and displays the board' do
    #     allow($stdout).to receive(:puts)
    #     expect(game).to receive(:gets).and_return("1")
    #     expect(game).to receive(:display_board)

    #     game.turn

    #     board = game.instance_variable_get(:@board)
    #     expect(board).to eq(["X", " ", " ", " ", " ", " ", " ", " ", " "])
    #   end

    #   it 'asks for input again after a failed validation' do
    #     game = ConnectFour.new
    #     allow($stdout).to receive(:puts)

    #     expect(game).to receive(:gets).and_return("invalid")
    #     expect(game).to receive(:gets).and_return("1")

    #     game.turn
    #   end
    # end

    # describe "#won?" do
    #   it 'returns false for a draw' do
    #     game = ConnectFour.new
    #     board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
    #     game.instance_variable_set(:@board, board)

    #     expect(game.won?).to be_falsey
    #   end

    #   it 'returns the winning combo for a win' do
    #     game = ConnectFour.new
    #     board = ["X", "O", "X", "O", "X", "O", "O", "X", "X"]
    #     game.instance_variable_set(:@board, board)

    #     expect(game.won?).to contain_exactly(0,4,8)
    #   end
    # end

    # describe '#full?' do
    #   it 'returns true for a draw' do
    #     game = ConnectFour.new
    #     board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
    #     game.instance_variable_set(:@board, board)

    #     expect(game.full?).to be_truthy
    #   end

    #   it 'returns false for an in-progress game' do
    #     game = ConnectFour.new
    #     board = ["X", " ", "X", " ", "X", " ", "O", "O", " "]
    #     game.instance_variable_set(:@board, board)

    #     expect(game.full?).to be_falsey
    #   end
    # end

    # describe '#draw?' do
    #   it 'returns true for a draw' do
    #     game = ConnectFour.new
    #     board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
    #     game.instance_variable_set(:@board, board)

    #     expect(game.draw?).to be_truthy
    #   end

    #   it 'returns false for a won game' do
    #     game = ConnectFour.new
    #     board = ["X", "O", "X", "O", "X", "X", "O", "O", "X"]
    #     game.instance_variable_set(:@board, board)

    #     expect(game.draw?).to be_falsey
    #   end

    #   it 'returns false for an in-progress game' do
    #     game = ConnectFour.new
    #     board = ["X", " ", "X", " ", "X", " ", "O", "O", "X"]
    #     game.instance_variable_set(:@board, board)

    #     expect(game.draw?).to be_falsey
    #   end
    # end

    # describe '#over?' do
    #   it 'returns true for a draw' do
    #     game = ConnectFour.new
    #     board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
    #     game.instance_variable_set(:@board, board)

    #     expect(game.over?).to be_truthy
    #   end

    #   it 'returns true for a won game' do
    #     game = ConnectFour.new
    #     board = ["X", "O", "X", "O", "X", "X", "O", "O", "X"]
    #     game.instance_variable_set(:@board, board)

    #     expect(game.over?).to be_truthy
    #   end

    #   it 'returns false for an in-progress game' do
    #     game = ConnectFour.new
    #     board = ["X", " ", "X", " ", "X", " ", "O", "O", " "]
    #     game.instance_variable_set(:@board, board)

    #     expect(game.over?).to be_falsey
    #   end
    # end

    # describe '#winner' do
    #   it 'return X when X won' do
    #     game = ConnectFour.new
    #     board = ["X", " ", " ", " ", "X", " ", " ", " ", "X"]
    #     game.instance_variable_set(:@board, board)

    #     expect(game.winner).to eq("X")
    #   end

    #   it 'returns O when O won' do
    #     game = ConnectFour.new
    #     board = ["X", "O", " ", " ", "O", " ", " ", "O", "X"]
    #     game.instance_variable_set(:@board, board)

    #     expect(game.winner).to eq("O")
    #   end

    #   it 'returns nil when no winner' do
    #     game = ConnectFour.new
    #     board = ["X", "O", " ", " ", " ", " ", " ", "O", "X"]
    #     game.instance_variable_set(:@board, board)

    #     expect(game.winner).to be_nil
    #   end
    # end
  end
end
