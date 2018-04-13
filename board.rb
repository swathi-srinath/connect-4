class Board
  # class constants
  BOARD_ROWS = 6
  BOARD_COLS = 7

  def initialize()
    @board   = Array.new(BOARD_ROWS){Array.new(BOARD_COLS,'x')}
    self.display_board
  end
  def display_board
    @board.each do |row|
      puts row.each {|cell| cell}.join("|")
    end
  end
  # This function will help the current player to calculate the next move
  # which will make him win in fewer moves. This method needs to be implemented with
  # an algorithm that possibly calculates the current board position and considers the
  # previous move of the opponent player and returns  a suggestion of a winning move.

  def calculate_winning_move()
    puts "Sorry mate! I am still being implemented. Will assist you soon in making a winning move."
  end

  # This method makes the move based on the column selected by the player.
  def make_move(player_token,player_column)
    # reverse is used because the board is filled bottom up
    @board.reverse.each do |row|
      if row[player_column] == 'x'
        row[player_column] = player_token
        break
      end
    end
    # display the board positions after each move
    self.display_board
    # Check for victory after each move.
    if check_win(player_token,player_column)
      return true
    else
      return false
    end

  end

  def check_win(player_token,player_column)
    # Check for consecutive four tokens horizontally
    for ctr1 in 0...@board.length
      @row         = @board[ctr1]
      @row_counter = 0
      for ctr2 in 0...@row.length

        if @row[ctr2] == player_token
          @row_counter +=1

          if @row_counter ==4
            return true
          end
        else
          @row_counter = 0
        end
      end

    end
    # check for consecutive four tokens vertically
    @col_counter = 0
    for ctr1 in 0...@board.length

      if @board[ctr1][player_column] == player_token
        @col_counter += 1
        if @col_counter == 4
          return true
        end
      end
    end
    # check for consecutive four tokens diagonally starting with col 0
    for diag_index in 0..11
      @diag_counter = 0
      for ctr1 in 0..diag_index
        ctr2 = diag_index-ctr1
        if (defined?@board[ctr1][ctr2]).nil?
          next
        end
        if @board[ctr1][ctr2] == player_token
          @diag_counter += 1
          if @diag_counter == 4
            return true
          end
        else
          @diag_counter = 0
        end
      end
    end
    # check for consecutive four tokens diagonally starting with col 6
    for diag_index in (6).downto(-5)
      @diag_counter = 0
      ctr2 = 0
      for ctr1 in 0..7
        ctr2 = diag_index + ctr1
        if (defined?@board[ctr1][ctr2]).nil?
          next
        end
        if ctr2 < 7
          if @board[ctr1][ctr2] == player_token
            @diag_counter += 1
            if @diag_counter == 4
              return true
            end
          else
            @diag_counter =0

          end
        else
          break;
        end
      end
    end

  return false
  end
end
