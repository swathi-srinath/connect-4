require 'highline/import'
require_relative  'player'
require_relative 'board'

# Method which will start the game
def start_game
  # Read the file that contains game instructions and display on the console
  File.open("instructions.txt").each do |line|
    puts line
  end
  # Select player 1 and 2 as human or computer. If human provide a name for identification
  player_1 = ask("Player 1 option? ",Integer){|q| q.in = 1..3}
  if player_1 == 2
    player_1_name = ask("Name? ") { |q| q.validate = /\w+\Z/ }
    player_1_obj  = Player.new(player_1_name)
  else
    player_1_obj = Player.new()
  end

  player_2 = ask("Player 2 option? ",Integer){|q| q.in = 1..3}
  if  player_2 == 2
    player_2_name = ask("Name? ") { |q| q.validate = /\w+\Z/ }
    player_2_obj  = Player.new(player_2_name)
  else
    player_2_obj = Player.new()
  end
  # Create an array with two player objects. Each player gets a token which is same as his index in the array
  players = Array.new(2){Player.new}
  players[0] = player_1_obj
  players[1] = player_2_obj
  # Create a new game board
  new_board = Board.new()
  puts " To start, please select a column between 1-7"
  turn           = 1 # used to keep track of maximum number of turns in the game which is 7*6
  game_over_flag = 0 # set to 1 if game is over either by a win or a tie
  while(turn <= 42)
    players.each_with_index do |player,player_token|
    puts "Player #{player.name} turn"
    if player.name.eql?("Computer")
      # currently the computer takes a random move. This can be replaced with the calculate_winning_move() method
      # by implementing an algorithm to calculate the best move
      player_selection = rand(7)
    else
      # Take human player's column selection. reduce it by 1 because array indices start with 0
      player_selection = ask("Column?  ", Integer) { |q| q.in = 1..7 }
    end
    player_column = player_selection-1
    # call make_move which makes a move on behalf of player and checks if the move has made the player win
    win_flag = new_board.make_move(player_token,player_column)
    turn += 1
    if win_flag
      puts "Game over : Player #{player.name} won"
      game_over_flag = 1
    end
    if turn == 42
      puts "Game over : Its a tie!!"
      game_over_flag = 1
    end
    # if the game over flag is set, check if the players want to restart with a new game or end the game
    if game_over_flag == 1
      new_game = ask("Do you want to start new game ?(yes/no)"){|q| q.validate = /(yes|no)\Z/}
      if new_game.eql?('yes')
        start_game()
      else
        puts "See you.Have a good day!!"
      end
      return
    end
  end
end
end


start_game()


