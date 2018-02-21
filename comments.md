colored text: https://stackoverflow.com/questions/1489183/colorized-ruby-output

red style_id = 34
blue style_id = 31
grey style_id = 37
reset style_id = 0

set style \e[31m
text
reset style \e[0m


solid circle = "\u25CF"

all together
\e[#{style_id}m#{TEXT}\e[0m



    describe '#display_board' do
      it 'prints arbitrary arrangements of the board' do
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

        board = [
          [0,0,0,0,0,0,1], 
          [0,5,0,0,0,1,2], 
          [0,0,0,0,0,2,1], 
          [1,0,0,0,0,1,2], 
          [1,0,0,0,0,2,1], 
          [1,0,2,0,0,2,1]
        ]
        game.instance_variable_set(:@board, board)

        output = capture_puts{ game.display_board }

        expect(output).to include("+-+-+-+-+-+-+-+")
        expect(output).to include("|●|●|●|●|●|●|\e[34m●|")
        expect(output).to include("+-+-+-+-+-+-+-+")
        expect(output).to include("|●|●|●|●|●|\e[34m●|\e[31m●|")
        expect(output).to include("+-+-+-+-+-+-+-+")
        expect(output).to include("|●|●|●|●|●|\e[31m●|\e[34m●|")
        expect(output).to include("+-+-+-+-+-+-+-+")
        expect(output).to include("|\e[34m●|●|●|●|●|\e[34m●|\e[31m●|")
        expect(output).to include("+-+-+-+-+-+-+-+")
        expect(output).to include("|\e[34m●|●|●|●|●|\e[31m●|\e[34m●|")
        expect(output).to include("+-+-+-+-+-+-+-+")
        expect(output).to include("|\e[34m●|●|●|●|●|\e[31m●|\e[34m●|")
        expect(output).to include("+-+-+-+-+-+-+-+")
      end
    end