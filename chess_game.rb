# 
# chess game
# 
# 
# 
# y = mx + b    // m: slope, b: y-intercept
# 
# ------------------------------------------
# movement:
#      [allowed x-delta, allowed y-delta]
#      
#      E.g.  Rook:   [ [0, (-8..8)], [(-8..8), 0] ]
#            Knight: [ [1, 2], [1, -2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, 1], [-2, -1]  ]
#            Bishop: [ [(-8..8), (-8..8)] ]
#            Queen:  [ [0, (-8..8)], [(-8..8), 0], [(-8..8), (-8..8)] ]
#            King:   [ [0, (-1..1)], [(-1..1), 0], [(-1..1), (-1..1)] ]
#            Pawn:   [ [0, 1], [0, 2]{1st move}, [-1, 1]{attack}, [1, 1]{attack} ]
# - basic movement list
# - attack movement list
# - 1st movement list
# - blockable (true/false)
# 
# 
# 
# alternative:
# 
# - cross
# - diagonal
# - pawn
# - knight
# 
# * Pawn   : [pawn]
# 
# * Knight : [knight]
# 
# * Rook   : [cross, 8]
# 
# * Bishop : [diagonal, 8]
# 
# * Queen  : [[cross, 8], [diagonal, 8]]
# 
# * King   : [[cross, 1], [diagonal, 1]]
# 
# 
# 
# 
# 
# 
# 
# ------------------------------------------
# 
# position:  [x, y]   // x: 0-7, y: 0-7
# 
# ------------------------------------------
# 
# move:
#    [start_position, end_position]
# 
# ------------------------------------------
# 
# board: 
# 
#     +----------+----------+----------+----------+----------+----------+----------+----------+
#     |          |..........|          |..........|          |..........|          |..........|
#     |          |..........|          |..........|          |..........|          |..........|
#  8  |    Rb    |... Nb ...|    Bb    |... Qb ...|   Kb     |... Bb ...|    Nb    |... Rb ...|
#     |          |..........|          |..........|          |..........|          |..........|
#     |          |..........|          |..........|          |..........|          |..........|
#     +----------+----------+----------+----------+----------+----------+----------+----------+
#     |..........|          |..........|          |..........|          |..........|          |
#     |..........|          |..........|          |..........|          |..........|          |
#  7  |... Pb ...|    Pb    |... Pb ...|    Pb    |... Pb ...|    Pb    |... Pb ...|    Pb    |
#     |..........|          |..........|          |..........|          |..........|          |
#     |..........|          |..........|          |..........|          |..........|          |
#     +----------+----------+----------+----------+----------+----------+----------+----------+
#     |          |..........|          |..........|          |..........|          |..........|
#     |          |..........|          |..........|          |..........|          |..........|
#  6  |          |..........|          |..........|          |..........|          |..........|
#     |          |..........|          |..........|          |..........|          |..........|
#     |          |..........|          |..........|          |..........|          |..........|
#     +----------+----------+----------+----------+----------+----------+----------+----------+
#     |..........|          |..........|          |..........|          |..........|          |
#     |..........|          |..........|          |..........|          |..........|          |
#  5  |..........|          |..........|          |..........|          |..........|          |
#     |..........|          |..........|          |..........|          |..........|          |
#     |..........|          |..........|          |..........|          |..........|          |
#     +----------+----------+----------+----------+----------+----------+----------+----------+
#     |          |..........|          |..........|          |..........|          |..........|
#     |          |..........|          |..........|          |..........|          |..........|
#  4  |          |..........|          |..........|          |..........|          |..........|
#     |          |..........|          |..........|          |..........|          |..........|
#     |          |..........|          |..........|          |..........|          |..........|
#     +----------+----------+----------+----------+----------+----------+----------+----------+
#     |..........|          |..........|          |..........|          |..........|          |
#     |..........|          |..........|          |..........|          |..........|          |
#  3  |..........|          |..........|          |..........|          |..........|          |
#     |..........|          |..........|          |..........|          |..........|          |
#     |..........|          |..........|          |..........|          |..........|          |
#     +----------+----------+----------+----------+----------+----------+----------+----------+
#     |          |..........|          |..........|          |..........|          |..........|
#     |          |..........|          |..........|          |..........|          |..........|
#  2  |    Pw    |... Pw ...|    Pw    |... Pw ...|    Pw    |... Pw ...|    Pw    |... Pw ...|
#     |          |..........|          |..........|          |..........|          |..........|
#     |          |..........|          |..........|          |..........|          |..........|
#     +----------+----------+----------+----------+----------+----------+----------+----------+
#     |..........|          |..........|          |..........|          |..........|          |
#     |..........|          |..........|          |..........|          |..........|          |
#  1  |... Rw ...|    Nw    |... Bw ...|    Qw    |... Kw ...|    Bw    |... Nw ...|    Rw    |
#     |..........|          |..........|          |..........|          |..........|          |
#     |..........|          |..........|          |..........|          |..........|          |
#     +----------+----------+----------+----------+----------+----------+----------+----------+
# 
#          a          b          c          d          e          f          g          h
# 
# 
# ------------------------------------------
# 
# piece:
# - player {w or b (white or black)}
# - symbol (P, R, N, B, Q, K)
# - movement: (see movement data type above)
# - position: (see position above)
# 
# 
# ------------------------------------------
# move validation:
# - start and end must be on the board
# - start position must have a piece of player's color
# - end may not have a piece of the player's color
# - path from start to end may not be blocked (except for knights)
# - special cases:
#   -- castling
#   -- en passant
#   -- promotion of pawns
# 
# 
# 
# 
# 
# 
# 
# 
# 

require 'yaml'
require_relative 'player.rb'
require_relative 'board.rb'


class ChessGame

  ##########################
  def initialize
    @white_player = Player.new('white')
    @black_player = Player.new('black')
    @current_player = @white_player
    @board = Board.new
  end

  ##########################
  def play
    finished = false
    check = nil
    check_move = nil
    check_piece = nil
    #    test_setup
    print "Load saved game? [Y/N]: "
    load = gets.chomp.downcase
    load_game if load == 'y'
    game_saved = false
    while !finished
      @board.draw
      puts "Game Saved!" if game_saved
      puts "#{check[0].color} #{check[0].name} in check! (#{check_move}, By: #{check_piece.color} #{check_piece.name})" if check
      # puts "#{check[0].color} #{check[0].name} in check! (#{check_move})" if check

      ##########################################
      # decide on using find_check here (for loaded game)
      ##########################################
      check = @board.find_check
      if check
        move_element = MoveHistoryElement.new(check[1], @board.get_piece_at(check[1][0]))
        check_move = move_element.move_to_chess_coords
        check_piece = move_element.piece
        puts "#{check[0].color} #{check[0].name} in check! (#{check_move}, By: #{check_piece.color} #{check_piece.name})"
      end

      game_saved = false
      move = @current_player.get_move
      puts "move: #{move}"
      if move.class == String && move.downcase == 's'
        save_game
        game_saved = true
        next
      end
      exit if move.class == String && move.downcase == 'q'

      valid = nil
      invalid_tries = 10
      while !(valid = @board.move_valid?(move))
        @board.draw
        puts "Invalid move, try again..."
        invalid_moves_quit if invalid_tries == 0
        invalid_tries -= 1

        game_saved = false
        move = @current_player.get_move
        puts "move: #{move}"
        if move.class == String && move.downcase == 's'
          save_game
          game_saved = true
          valid = 'next'
          next
        end
        exit if move.class == String && move.downcase == 'q'
      end

      next if valid == 'next'

      puts "******* play -- valid: #{valid}"
      if valid == 'castle'
        castle(move)
      elsif valid == 'en_passant'
        en_passant(move)
      else
        @board.move_piece(move)
      end
      
      check = @board.find_check
      if check
        move_element = MoveHistoryElement.new(check[1], @board.get_piece_at(check[1][0]))
        check_move = move_element.move_to_chess_coords
        check_piece = move_element.piece
        puts "#{check[0].color} #{check[0].name} in check! (#{check_move}, By: #{check_piece.color} #{check_piece.name})"
      end
#      puts "#{check[0].color} #{check[0].name} in check! (#{check[1].inspect})" if check
      if !(finished = determine_finished(check))
        next_player
      end
    end
    @board.draw
    announce_result(finished)  # (white/black) checkmate, stalemate
  end # def play

  
  def castle(move)
    puts "Entering castle function -- move: #{move.inspect}"
    @board.move_piece(move)

    # white king-side castle
    if move == [[4,0],[6,0]]
      @board.move_piece([[7,0],[5,0]])
    end

    # white queen-side castle
    if move == [[4,0],[2,0]]
     @board.move_piece([[0,0],[3,0]])
    end

    # black king-side castle
    if move == [[4,7],[6,7]]
      @board.move_piece([[7,7],[5,7]])
    end

    # black queen-side castle
    if move == [[4,7],[2,7]]
      @board.move_piece([[0,7],[3,7]])
    end
  end

  def en_passant(move)
    @board.board[move[1][0]][move[0][1]] = nil
    @board.move_piece(move)
  end

  def test_setup
    @board.clear
    board = @board.board
    black_king = King.new
    black_king.color = 'black'
    white_pawn = Pawn.new
    white_pawn.color = 'white'
    white_king = King.new
    white_king.color = 'white'
    board[5][7] = black_king
    board[5][6] = white_pawn
    board[5][4] = white_king
    @board.set_display_board_from_board
  end

  # returns false | white | black | stalemate
  def determine_finished(check)
    # determine checkmate (only if checked)
    if (finished = determine_checkmate(check) if check)
      return finished
    end
    
    # determine stalemate
    return 'stalemate' if stalemate?

    false
  end


  ###############################
  # only call when in check
  # returns false | white | black 
  ###############################
  def determine_checkmate(check)
    move_element = MoveHistoryElement.new(check[1], @board.get_piece_at(check[1][0]))

    # can't evade (castling can't be considered)
    return false if can_evade?(move_element)
    
    # can't block (knights immune)
    if move_element.piece.name != 'Knight'
      return false if can_block?(move_element)
    end

   # can't capture
    return false if can_capture?(move_element)

    move_element.piece.color
  end

  ##########################
  def can_block?(move_history_element)
    move = move_history_element.move
    piece = move_history_element.piece
    dist = @board.position_distance(move)
    return false if dist < 2

    pieces = nil
    if piece.color == 'white'
      pieces = @board.black_pieces
    else
      pieces = @board.white_pieces
    end
    
    direction = nil
    if move[0][1] == move[1][1]
      direction = 'horizontal'
    elsif move[0][0] == move[1][0]
      direction = 'vertical'
    else
      direction = 'diagonal'
    end

    puts "attack direction: #{direction}"


    case direction
    when 'horizontal'
      y = move[0][1]
      start_x = [move[0][0], move[1][0]].min
      end_x   = [move[0][0], move[1][0]].max
      (start_x+1..end_x-1).each {|x|
        pieces.each {|el|
          if el[0].name != 'King'
            coords = el[1]
            move = [coords, [x, y]]
            puts "can_block? move test: #{move.inspect}, valid: #{@board.move_valid?(move)}"
            valid = @board.move_valid?(move)
            return true if valid
          end
        }
      }
      puts "start_x: #{start_x}, end_x: #{end_x}"
    when 'vertical'
      x = move[0][0]
      start_y = [move[0][1], move[1][1]].min
      end_y   = [move[0][1], move[1][1]].max
      (start_y+1..end_y-1).each {|y|
        pieces.each {|el|
          if el[0].name != 'King'
            coords = el[1]
            move = [coords, [x, y]]
            puts "can_block? move test: #{move.inspect}, valid: #{@board.move_valid?(move)}"
            valid = @board.move_valid?(move)
            return true if valid
          end
        }
      }
      puts "start_y: #{start_y}, end_y: #{end_y}"
    when 'diagonal'
      x_inc = move[0][0] < move[1][0] ? 1 : -1
      y_inc = move[0][1] < move[1][1] ? 1 : -1
      start_x = move[0][0] + (1 * x_inc)
      start_y = move[0][1] + (1 * y_inc)
      end_x = move[1][0] - (1 * x_inc)
      end_y = move[1][1] - (1 * y_inc)
      current_pos = [start_x, start_y]
      end_pos = [end_x, end_y]
      while current_pos != end_pos
        x = current_pos[0]
        y = current_pos[1]

        pieces.each {|el|
          if el[0].name != 'King'
            coords = el[1]
            move = [coords, [x, y]]
            puts "can_block? move test: #{move.inspect}, valid: #{@board.move_valid?(move)}"
            valid = @board.move_valid?(move)
            return true if valid
          end
        }

        current_pos[0] += x_inc
        current_pos[1] += y_inc
      end
    else
      puts "Fatal Error: Impossible attack direction encountered (#{move_history_element})"
    end
    
    false
  end

  def can_capture?(move_history_element)
    position_to_capture = move_history_element.move[0]
    piece_to_capture = @board.get_piece_at(position_to_capture)

    pieces = nil
    if piece_to_capture.color == 'white'
      pieces = @board.black_pieces
    else
      pieces = @board.white_pieces
    end
    pieces.each {|el|
        return true if @board.move_valid?([el[1], position_to_capture])
    }

    false
  end

  def can_evade?(move_history_element)
    enemy_pieces = nil
    attacking_piece_pos = move_history_element.move[0]
    defending_king_pos = move_history_element.move[1]
    defending_king = move_history_element.piece
    puts "attacking_piece_pos: #{attacking_piece_pos.inspect}, defending_king_pos: #{defending_king_pos.inspect}"
    puts "current_player: #{@current_player.color}"
    defending_king.raw_move_list(defending_king_pos).each{|pos|
      return true if @board.move_valid?([defending_king_pos, pos]) # move_valid? verifies king not moving into check, etc.
    }
    
    return false
  end
  
  def stalemate?
    if @current_player.color == 'white'
      enemy_pieces = @board.black_pieces
    else
      enemy_pieces = @board.white_pieces
    end

    enemy_pieces.each {|el|
      piece = el[0]
      position = el[1]
      move_list = piece.raw_move_list(position)
      move_list.each {|new_pos|
        valid = @board.move_valid?([position, new_pos])
        return false if valid
      }
    }
    
    true
  end
  
  def announce_result(result)
    if result == 'stalemate'
      puts "Game Over: Stalemate!"
    else
      puts "Game Over: #{result.capitalize} Wins!"
    end
  end

  ##########################
  def next_player
    @current_player = (@current_player == @white_player) ? @black_player : @white_player
  end


  def invalid_moves_quit
    puts "Stopping Game -- too many invalid moves..."
    exit
  end

  def save_game
    filename = "./data/chess_" + Time.now.strftime('%d_%b_%Y-%H%M') + ".gam"
    file = File.new(filename, "w")
    YAML.dump(@board, file)
    if @current_player.color == 'white'
      YAML.dump('white', file)
    else
      YAML.dump('black', file)
    end
    file.close
  end

  def load_game
    puts 'Load Game function called... (unimplemented)'
    index = 0
    file_list = Dir.glob("./data/*.gam")
    game_list = Dir.glob("./data/*.gam").map {|file|
      index += 1
      file = "#{index.to_s[0..2]}.  #{file}"
    }

    game_list.each {|entry|
      puts entry
    }
    print "Enter number of game to load: "
    game_number = STDIN.gets.to_i - 1
    puts ""
    puts "selected game file: #{file_list[game_number]}"
    filename = file_list[game_number]
    data_array = YAML.load_stream(File.open(filename))
    @board = data_array[0]
    if data_array[1] == 'white'
      @current_player = @white_player
    else
      @current_player = @black_player
    end
  end
  
end # class ChessGame
############################################################################

game = ChessGame.new
game.play
