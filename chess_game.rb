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
    while !finished
      @board.draw
      puts "#{check[0].color} #{check[0].name} in check! (#{check_move}, By: #{check_piece.color} #{check_piece.name})" if check
      # puts "#{check[0].color} #{check[0].name} in check! (#{check_move})" if check

      # TODO: handle move == load/save game
      move = @current_player.get_move
      invalid_tries = 10
      while !@board.move_valid?(move)
        @board.draw
        puts "Invalid move, try again..."
        invalid_moves_quit if invalid_tries == 0
        invalid_tries -= 1

        # TODO: handle move == load/save game
        move = @current_player.get_move
      end

      @board.move_piece(move)
      
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


  ##########################
  # TODO: Implement
  ##########################
  # returns false | white | black | stalemate
  def determine_finished(check)
    # determine checkmate (only if checked)
    if (finished = determine_checkmate(check) if check)
      return finished
    end
    
    # determine stalemate

    false
  end


  ###########################################
  # TODO: move this function to Board class
  ###########################################
  # returns [king piece, move] or nil  (move to attack king)
#  def find_check
#    white_pieces = @board.white_pieces
#    black_pieces = @board.black_pieces
#    white_king = nil
#    white_pieces.each {|el|
#      white_king = el if el[0].name == 'King'
#    }
#    black_king = nil
#    black_pieces.each {|el|
#      black_king = el if el[0].name == 'King'
#    }
#
#    white_king_pos = white_king[1]
#    black_king_pos = black_king[1]
#
#    black_pieces.each {|el|
#      move = [el[1], white_king_pos]
#      if @board.move_valid?(move)
#        white_king[0].can_castle = false
#        white_king[0].check = true
#        return [white_king[0], move]
#      end
#    }
#
#    white_pieces.each {|el|
#      move = [el[1], black_king_pos]
#      if @board.move_valid?(move)
#        black_king[0].can_castle = false
#        black_king[0].check = true
#        return [black_king[0], move]
#      end
#    }
#
#    nil
#  end

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
      if @board.move_valid?([defending_king_pos, pos])
        puts "can_evade? -- defending king pos: #{defending_king_pos.inspect}, test valid move to: #{pos.inspect}"
        ################################################
        # TODO: *** Consider making the king move into check a test within the move_valid? function...
        ################################################
        board = Board.new
        #        board.board = @board.board
        board.copy(@board)
        board.move_piece([defending_king_pos, pos])
        if @current_player == @white_player   # current_player is the attacking player
          enemy_pieces = board.white_pieces  # enemy from threatened king POV
        else
          enemy_pieces = board.black_pieces  # enemy from threatened king POV
        end

        safe_move = true
        enemy_pieces.each {|el|
          if board.move_valid?([el[1], pos])   # using temporary board here (with king's evading move)
            safe_move = false
          end
        }
        puts "can_evade? -- safe_move = #{safe_move}"
        return true if safe_move
      end
    }
    return false
  end
  
  ##########################
  # TODO: implement
  ##########################
  def determine_stalemate
  end
  
  def announce_result(result)
    puts "Winner is: #{result}"
  end
  
#  ##########################
#  def move_valid?(move)
#    puts "*** move_valid? checking move: #{move.inspect}"
#    
#    # all moves must be on the board
#    return false if !move[0][0].between?(0,7)
#    return false if !move[0][1].between?(0,7)
#    return false if !move[1][0].between?(0,7)
#    return false if !move[1][1].between?(0,7)
#
#    current_player = nil
#    start_piece = @board.get_piece_at(move[0])
#    if start_piece.color == 'white'
#      current_player = @white_player
#    else
#      current_player = @black_player
#    end
#    
#    end_piece = @board.get_piece_at(move[1])
#
#    # start position must have a piece of player's color
#    if start_piece == nil
#      puts "*** move_valid? returning false: start_piece is nil, move: #{move.inspect}"
#      return false
#    else
#      puts "*** move_valid? returning false: start_piece color != player color, move: #{move.inspect}" if start_piece.color != current_player.color
#      return false if start_piece.color != current_player.color
#    end
#
#    # end may not have a piece of the player's color
#    if end_piece != nil
#      puts "*** move_valid? returning false: end_piece is nil, move: #{move.inspect}" if end_piece.color == current_player.color
#      return false if end_piece.color == current_player.color
#    end
#
#    # start and end positions match piece's movement rules
#    reachable = start_piece.potentially_reachable?(move[0], move[1])
#    puts "*** move_valid? returning false: reachable: #{reachable}, move: #{move.inspect}" if !reachable
#    return false if !reachable
#
#    # path from start to end may not be blocked (except for knights)
#    if start_piece.name != 'Knight'
#      # path from start to end may not be blocked (except for knights)
#      valid_path = @board.valid_path?(move)
#      puts "*** move_valid? returning false: valid_path: #{valid_path}" if !valid_path
#      return false if !valid_path
#    end
#
#    if start_piece.name == 'Pawn'
#      if start_piece.attack?(move[0], move[1])
#        # pawn attack
#        puts "*** move_valid? returning false: pawn attack end_piece == nil: #{end_piece == nil}" if end_piece == nil
#        return false if end_piece == nil
#        puts "*** move_valid? returning false: pawn attack color == end piece color: #{start_piece.color == end_piece.color}" if start_piece.color == end_piece.color
#        return false if start_piece.color == end_piece.color
#      else
#        # check that pawn destination empty
#        # (probably unnecessary check since valid_path check above should cover this)
#        puts "*** move_valid? returning false: pawn end piece != nil: #{end_piece != nil}" if end_piece != nil
#        return false if end_piece != nil
#      end
#    end
#    
#    ### TODO
#    # - special cases:
#    #   -- castling
#    #   -- en passant
#    #   -- promotion of pawns
#    # - can't move into check
#    # - when in check, move must remove check
#
#    puts "*** move_valid? returning true"
#    puts ""
#    true
#  end # def move_valid?(move)

  ##########################
  def next_player
    @current_player = (@current_player == @white_player) ? @black_player : @white_player
  end


  def invalid_moves_quit
    puts "Stopping Game -- too many invalid moves..."
    exit
  end

  ##########################
  # TODO: implement
  ##########################
  def save_game
    # save board
    # save current_player
  end

  ##########################
  # TODO: implement
  ##########################
  def load_game
  end
  
end # class ChessGame
############################################################################

game = ChessGame.new
game.play
