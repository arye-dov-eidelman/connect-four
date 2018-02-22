class ConnectFour
  #attr_accessor 
  attr_reader :board, :RED, :BLUE, :GREY

  @@RED = "31"
  @@BLUE = "34"
  @@GREY = "37"
  def initialize
    @board = [
      [0,0,0,0,0,0,0], 
      [0,0,0,0,0,0,0], 
      [0,0,0,0,0,0,0], 
      [0,0,0,0,0,0,0], 
      [0,0,0,0,0,0,0], 
      [0,0,0,0,0,0,0]
    ]
  end
  def colorize(string, color)
    return "\e[#{color}m#{string}\e[0m"
  end
  def display_board()
    @board.each do |row|
      puts "+---+---+---+---+---+---+---+"
      print '|'
      row.each do |cell|
        case cell
          when 1
            print " " + colorize("●", @@RED) + " |"
          when 2
            print " " + colorize("●", @@BLUE) + " |"
          else
            print " ● |"
        end
      end
      puts ''
    end
    puts "+---+---+---+---+---+---+---+"
  end
  def input_to_index(user_input)
    user_input.to_i - 1
  end
  def move(index, current_player)
    i = 5 # the height of the board starting from 0 
    loop do
      if @board[i][index] == 0
        @board[i][index] = current_player
        break
      else
        i -= 1
      end
    end
  end
  def position_taken?(index)
    @board[0][index] != 0
  end
  def valid_move?(index)
    index.between?(0,6) && !position_taken?(index)
  end
  def turn_count
    result = 0
    @board.each do |row|
      row.each do |cell|
        if cell != 0
          result+=1
        end
      end
    end
    return result
  end
  def current_player
    if turn_count % 2 == 0
      return 1
    end
    return 2
  end
  def player_number_to_color(player)
    if player == 1
      return 'Red'
    end
    if player == 2
      return 'player_number_to_color invalid number it needs to be 1 or 2'
    end

  return 'Blue'
end
  def turn
    puts ""
    puts "Its #{player_number_to_color(current_player)}'s turn, Please enter 1-7:"
    index = input_to_index(gets.strip)
    puts ""
    if valid_move?(index)
      move(index, current_player)
      display_board
      puts ""
    else
      turn
    end
  end
  def won?
    # WIN_COMBINATIONS.each do |win_combination|
    #   position = [@board[win_combination[0]], @board[win_combination[1]], @board[win_combination[2]]]
    #   if position[0] == "X" && position[1] == "X" && position[2] == "X"
    #     return win_combination
    #   end
    #   if position[0] == "O" && position[1] == "O" && position[2] == "O"
    #     return win_combination
    #   end
    # end
    return false
  end
  def full?
    @board[0].each do |cell|
      if cell == 0
        return false
      end
    end
    return true
  end
  def draw?
    if full? && !won?
      return true
    end
    return false
  end
  def over?
    if full? || won? || draw?
      # "|| draw?" cant be true without a nother evaluation
      # being true but must be called for the tests
      return true
    end
    return false
  end
  def winner
    @board[won?[0][0]][won?[0][1]]
  end
  def play
    if turn_count == 0
      display_board
    end
    while !over?
      turn
    end
    if draw?
      puts "Cat's Game!"
    else
      puts "Congratulations #{winner}!"
    end
  end
end
