class Board

  def initialize
    @board = Array.new(3) { Array.new(3, " ") }
  end

  def printGameInstructions
    puts "\n===== 3X3 Board ======\n"
    puts "Player1 = X\n"
    puts "Player2 = O\n\n"
    puts "1 | 2 | 3",
         "---------",
         "4 | 5 | 6",
         "---------",
         "7 | 8 | 9"
    print "\n"
  end

  def printGameBoard
    (0..2).each do |row|
      print "       "
      (0..2).each do |col|
        print @board[row][col]
        print " | " unless col == 2
      end
      print "\n"
      print "       ---------\n" unless row == 2
    end
    print "\n"
  end

  def scanWinner
    (0..2).each do |i|
      if @board[i][0] == @board[i][1] && @board[i][1] == @board[i][2]
        return @board[i][0] unless @board[i][0] == " "

      elsif @board[0][i] == @board[1][i] && @board[1][i] == @board[2][i]
        return @board[0][i] unless @board[0][i] == " "
      end
    end

    if ( @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] ) ||
       ( @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] )
      return @board[1][1] unless @board[1][1] == " "
    end

    return "C" unless @board.join.split('').include?(" ")

    return "U"
  end

  def dropPiece(piece, row, col)
    @board[row][col] = piece if (0..2) === row &&
                                (0..2) === col &&
                                @board[row][col] == " "
  end

  def startGame
    printGameInstructions
    active_player = "X"
    
    while scanWinner == "U"
      puts "#{active_player}'s turn. Choose a box move (1-9)!"

      print "           "
      move = gets.chomp.to_i - 1
      row = move / 3
      col = move % 3

      puts "\n"

      if dropPiece(active_player, row, col)
        if active_player == "X"
          active_player = "O"
        else
          active_player = "X"
        end
      else
        puts "!!!!! Invalid move, please select again !!!!!\n\n"
      end

      printGameBoard
    end

    printResult
  end

  def printResult
    winner = scanWinner
    puts "\n" * 2

    if winner == "C"
      puts "   C A T S   G A M E"
    else
      puts "Game Over!!! '#{winner}' WON THE GAME"
    end

    printGameBoard
  end
end

board = Board.new
board.startGame