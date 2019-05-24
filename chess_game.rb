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
    while !finished
      @board.draw
      puts check if check

      # TODO: handle move == load/save game
      move = @current_player.get_move
      invalid_tries = 10
      while !move_valid?(move)
        @board.draw
        puts "Invalid move, try again..."
        invalid_moves_quit if invalid_tries == 0
        invalid_tries -= 1

        # TODO: handle move == load/save game
        move = @current_player.get_move
      end
      @board.move_piece(move)
      check = find_check
      puts check if check
      if !(finished = determine_finished(check))
        next_player
      end
    end
    announce_result(finished)  # (white/black) checkmate, stalemate
  end # def play


  ##########################
  # TODO: Implement
  ##########################
  # returns false | white | black | stalemate
  def determine_finished(check)
    # find checkmate (only if checked)
    # find stalemate

    false
  end

  # TODO: mark threatened king as 'un-castlable'
  def find_check
    white_pieces = @board.white_pieces
    black_pieces = @board.black_pieces
    white_king = nil
    white_pieces.each {|el|
      white_king = el if el[0].name == 'King'
    }
    black_king = nil
    black_pieces.each {|el|
      black_king = el if el[0].name == 'King'
    }

    white_king_pos = white_king[1]
    black_king_pos = black_king[1]

    black_pieces.each {|el|
      move = [el[1], white_king_pos]
      if move_valid?(move)
        white_king.can_castle = false
        return '***** black checks white!'
      end
    }

    white_pieces.each {|el|
      move = [el[1], black_king_pos]
      if move_valid?(move)
        black_king.can_castle = false
        return '*****  white checks black!'
      end
    }

    nil
  end

  ##########################
  # TODO: implement
  ##########################
  # only call when in check
  def find_checkmate
    # mark threatened king with no-castle
    # can't block (knights immune)
    # can't capture
    # can't evade (castling can't be considered)
  end

  ##########################
  # TODO: implement
  ##########################
  def find_stalemate
  end
  
  def announce_result(result)
    puts "Winner is: #{result}"
  end
  
  ##########################
  def move_valid?(move)
    start_piece = @board.get_piece_at(move[0])
    end_piece = @board.get_piece_at(move[1])
    
    # start position must have a piece of player's color
    if start_piece == nil
      return false
    else
      return false if start_piece.color != @current_player.color
    end

    # end may not have a piece of the player's color
    if end_piece != nil
      return false if end_piece.color == @current_player.color
    end

    # start and end positions match piece's movement rules
    return false if !start_piece.potentially_reachable?(move[0], move[1])

    # path from start to end may not be blocked (except for knights)
    if start_piece.name != 'Knight'
      # path from start to end may not be blocked (except for knights)
      valid_path = @board.valid_path?(move)
      return false if !valid_path
    end

    if start_piece.name == 'Pawn'
      if start_piece.attack?(move[0], move[1])
        # pawn attack
        return false if end_piece == nil
        return false if start_piece.color == end_piece.color
      else
        # check that pawn destination empty
        # (probably unnecessary check since valid_path check above should cover this)
        return false if end_piece != nil
      end
    end
    
    ### TODO
    # - special cases:
    #   -- castling
    #   -- en passant
    #   -- promotion of pawns
    # - can't move into check

    
    true
  end

  ##########################
  def next_player
    @current_player = @current_player == @white_player ? @black_player : @white_player
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


game = ChessGame.new
game.play
