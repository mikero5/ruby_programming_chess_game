# 
# 
# 
# 
require_relative 'piece.rb'
require 'cmath'

class MoveHistoryElement
  attr_reader :piece
  attr_reader :move
  
  def initialize(move, piece)
    @move = move
    @piece = piece
  end

  def clone
    piece = @piece.clone
    move = [[@move[0][0], @move[0][1]], [@move[1][0], @move[1][1]]]
    MoveHistoryElement.new(move, piece)
  end

  def to_string
    "#{@piece.color}: #{move_to_chess_coords.inspect}, #{@piece.name} "
  end

  def move_to_chess_coords
    start_x = ('a'.ord + @move[0][0]).chr
    start_y = (@move[0][1] + 1).to_s
    end_x = ('a'.ord + @move[1][0]).chr
    end_y = (@move[1][1] + 1).to_s
    [start_x + start_y, end_x + end_y]
  end

end # class MoveHistoryElement


class Board
  attr_accessor :board
  attr_accessor :non_pawn_move_count
  attr_accessor :display_board
  attr_accessor :captured
  attr_accessor :moves
  attr_accessor :non_pawn_move_count
  attr_accessor :piece_display
  
  def initialize
    @board = Array.new(8) { Array.new(8) }
    @display_board = Array.new(8) { Array.new(8) {'~~'} }
    @captured = []
    @moves = []
    @non_pawn_move_count = 0

    @piece_display = ["  8  |    #{@display_board[0][7] ? @display_board[0][7] : '  '}    |... #{@display_board[1][7] ? @display_board[1][7] : '  '} ...|    #{@display_board[2][7] ? @display_board[2][7] : '  '}    |... #{@display_board[3][7] ? @display_board[3][7] : '  '} ...|    #{@display_board[4][7] ? @display_board[4][7] : '  '}    |... #{@display_board[5][7] ? @display_board[5][7] : '  '} ...|    #{@display_board[6][7] ? @display_board[6][7] : '  '}    |... #{@display_board[7][7] ? @display_board[7][7] : '  '} ...|",
                      "  7  |... #{@display_board[0][6] ? @display_board[0][6] : '  '} ...|    #{@display_board[1][6] ? @display_board[1][6] : '  '}    |... #{@display_board[2][6] ? @display_board[2][6] : '  '} ...|    #{@display_board[3][6] ? @display_board[3][6] : '  '}    |... #{@display_board[4][6] ? @display_board[4][6] : '  '} ...|    #{@display_board[5][6] ? @display_board[5][6] : '  '}    |... #{@display_board[6][6] ? @display_board[6][6] : '  '} ...|    #{@display_board[7][6] ? @display_board[7][6] : '  '}    | ",
                      "  6  |    #{@display_board[0][5] ? @display_board[0][5] : '  '}    |... #{@display_board[1][5] ? @display_board[1][5] : '  '} ...|    #{@display_board[2][5] ? @display_board[2][5] : '  '}    |... #{@display_board[3][5] ? @display_board[3][5] : '  '} ...|    #{@display_board[4][5] ? @display_board[4][5] : '  '}    |... #{@display_board[5][5] ? @display_board[5][5] : '  '} ...|    #{@display_board[6][5] ? @display_board[6][5] : '  '}    |... #{@display_board[7][5] ? @display_board[7][5] : '  '} ...|",
                      "  5  |... #{@display_board[0][4] ? @display_board[0][4] : '  '} ...|    #{@display_board[1][4] ? @display_board[1][4] : '  '}    |... #{@display_board[2][4] ? @display_board[2][4] : '  '} ...|    #{@display_board[3][4] ? @display_board[3][4] : '  '}    |... #{@display_board[4][4] ? @display_board[4][4] : '  '} ...|    #{@display_board[5][4] ? @display_board[5][4] : '  '}    |... #{@display_board[6][4] ? @display_board[6][4] : '  '} ...|    #{@display_board[7][4] ? @display_board[7][4] : '  '}    | ",
                      "  4  |    #{@display_board[0][3] ? @display_board[0][3] : '  '}    |... #{@display_board[1][3] ? @display_board[1][3] : '  '} ...|    #{@display_board[2][3] ? @display_board[2][3] : '  '}    |... #{@display_board[3][3] ? @display_board[3][3] : '  '} ...|    #{@display_board[4][3] ? @display_board[4][3] : '  '}    |... #{@display_board[5][3] ? @display_board[5][3] : '  '} ...|    #{@display_board[6][3] ? @display_board[6][3] : '  '}    |... #{@display_board[7][3] ? @display_board[7][3] : '  '} ...|",
                      "  3  |... #{@display_board[0][2] ? @display_board[0][2] : '  '} ...|    #{@display_board[1][2] ? @display_board[1][2] : '  '}    |... #{@display_board[2][2] ? @display_board[2][2] : '  '} ...|    #{@display_board[3][2] ? @display_board[3][2] : '  '}    |... #{@display_board[4][2] ? @display_board[4][2] : '  '} ...|    #{@display_board[5][2] ? @display_board[5][2] : '  '}    |... #{@display_board[6][2] ? @display_board[6][2] : '  '} ...|    #{@display_board[7][2] ? @display_board[7][2] : '  '}    | ",
                      "  2  |    #{@display_board[0][1] ? @display_board[0][1] : '  '}    |... #{@display_board[1][1] ? @display_board[1][1] : '  '} ...|    #{@display_board[2][1] ? @display_board[2][1] : '  '}    |... #{@display_board[3][1] ? @display_board[3][1] : '  '} ...|    #{@display_board[4][1] ? @display_board[4][1] : '  '}    |... #{@display_board[5][1] ? @display_board[5][1] : '  '} ...|    #{@display_board[6][1] ? @display_board[6][1] : '  '}    |... #{@display_board[7][1] ? @display_board[7][1] : '  '} ...|",
                      "  1  |... #{@display_board[0][0] ? @display_board[0][0] : '  '} ...|    #{@display_board[1][0] ? @display_board[1][0] : '  '}    |... #{@display_board[2][0] ? @display_board[2][0] : '  '} ...|    #{@display_board[3][0] ? @display_board[3][0] : '  '}    |... #{@display_board[4][0] ? @display_board[4][0] : '  '} ...|    #{@display_board[5][0] ? @display_board[5][0] : '  '}    |... #{@display_board[6][0] ? @display_board[6][0] : '  '} ...|    #{@display_board[7][0] ? @display_board[7][0] : '  '}    | ",
                     ]

    (0..7).each {|x|
      pawn = Pawn.new
      pawn.color = 'white'
      @board[x][1] = pawn
      pawn = Pawn.new
      pawn.color = 'black'
      @board[x][6] = pawn
    }

    rook = Rook.new
    rook.color = "white"
    @board[0][0] = rook
    rook = Rook.new
    rook.color = "white"
    @board[7][0] = rook
    rook = Rook.new
    rook.color = "black"
    @board[0][7] = rook
    rook = Rook.new
    rook.color = "black"
    @board[7][7] = rook

    knight = Knight.new
    knight.color = "white"
    @board[1][0] = knight
    knight = Knight.new
    knight.color = "white"
    @board[6][0] = knight
    knight = Knight.new
    knight.color = "black"
    @board[1][7] = knight
    knight = Knight.new
    knight.color = "black"
    @board[6][7] = knight

    bishop = Bishop.new
    bishop.color = "white"
    @board[2][0] = bishop
    bishop = Bishop.new
    bishop.color = "white"
    @board[5][0] = bishop
    bishop = Bishop.new
    bishop.color = "black"
    @board[2][7] = bishop
    bishop = Bishop.new
    bishop.color = "black"
    @board[5][7] = bishop

    queen = Queen.new
    queen.color = "white"
    @board[3][0] = queen
    queen = Queen.new
    queen.color = "black"
    @board[3][7] = queen

    king = King.new
    king.color = "white"
    @board[4][0] = king
    king = King.new
    king.color = "black"
    @board[4][7] = king

    set_display_board_from_board
  end # initialize

  def clear
    (0..7).each {|i|
      (0..7).each {|j|
        @board[i][j] = nil
      }
    }
    set_display_board_from_board
  end
  
  def copy(rhs)
    (0..7).each {|i|
      (0..7).each {|j|
        copy_piece = nil
        piece = rhs.board[i][j]
        if piece != nil
          copy_piece = piece.clone
          @board[i][j] = copy_piece
        else
          @board[i][j] = rhs.board[i][j]
        end
      }
    }

    (0..7).each {|i|
      (0..7).each {|j|
        @display_board[i][j] = rhs.display_board[i][j]
      }
    }

    @moves.clear
    rhs.moves.each {|el|
      @moves.push(el.clone)
    }
    
    @moves = rhs.moves
    @captured = rhs.captured
    @non_pawn_move_count = rhs.non_pawn_move_count
    @piece_display = rhs.piece_display
  end
  
  def clone
    board = Board.new
    board.clear
    (0..7).each {|i|
      (0..7).each {|j|
        copy_piece = nil
        piece = @board[i][j]
        if piece != nil
          copy_piece = piece.clone
          board.board[i][j] = copy_piece
        else
          board.board[i][j] = @board[i][j]
        end
      }
    }

    (0..7).each {|i|
      (0..7).each {|j|
        board.display_board[i][j] = @display_board[i][j]
      }
    }

    @moves.each {|el|
      board.moves.push(el.clone)
    }
    
    board.captured = @captured
    board.non_pawn_move_count = @non_pawn_move_count
    board.piece_display = @piece_display
    board
  end
  
  def draw
    show_move_list
    set_piece_display_from_display_board
    line = '     +----------+----------+----------+----------+----------+----------+----------+----------+'
    wb_line = '     |          |..........|          |..........|          |..........|          |..........|'
    bw_line = '     |..........|          |..........|          |..........|          |..........|          |'
    tab = '     '

    
    4.times { |i|
      puts line
      2.times {|j| puts wb_line }
      puts @piece_display[i*2]
      2.times {|j| puts wb_line }
      puts line
      2.times { |j| puts bw_line }
      puts @piece_display[i*2+1]
      2.times { |j| puts bw_line }
    }
    puts line
    puts ""
    puts "#{tab}     a          b          c          d          e          f          g           h"
  end # draw

  def get_piece_at(position)
    @board[position[0]][position[1]]
  end # get_piece_at(position)

  def move_piece(move)
    # track captures
    captured_piece = @board[move[1][0]][move[1][1]]
    @captured.push(captured_piece) if captured_piece != nil

    # move the piece to new posiiton
    @board[move[1][0]][move[1][1]] = @board[move[0][0]][move[0][1]]

    piece = @board[move[1][0]][move[1][1]]

    # if Pawn, update move count
    @board[move[1][0]][move[1][1]].move_count += 1 if piece.name == 'Pawn'

    handle_pawn_promotion(move) if piece.name == 'Pawn' && move[1][1] == 7
    
    # if King or Rook, mark as 'no-castle'
    piece.can_castle = false if piece.name == 'King' || piece.name == 'Rook'

    # erase moved piece from old posiiton (on board & display_board)
    @board[move[0][0]][move[0][1]] = nil
    @display_board[move[0][0]][move[0][1]] = nil

    # store move
    @moves.push(MoveHistoryElement.new(move, piece))
    if piece.name == 'Pawn'
      @non_pawn_move_count = 0 # pawn is moved so reset the count to zero
    else
      @non_pawn_move_count += 1
      piece.can_castle = false if piece.name == 'King' || piece.name == 'Rook'
    end
    
    # update display_board
    set_display_board_from_board

    # show game move list
#    puts ""
#    puts "Move List:"
#    @moves.each_with_index {|el, i|
#      puts "#{i+1}. #{el.to_string}"
#    }
  end # move_piece(move)

  def show_move_list
    puts ""
    puts "Move List:"
    @moves.each_with_index {|el, i|
      puts "#{i+1}. #{el.to_string}"
    }
  end
  
  def handle_pawn_promotion(move)
    color = get_piece_at(move[1]).color
    valid = false
    piece = nil
    while !valid
      puts "Promote Pawn:"
      puts "(N) Knight"
      puts "(B) Bishop"
      puts "(R) Rook"
      puts "(Q) Queen"
      print "Enter piece abbr. to promote pawn to: "
      puts " (position #{move[1].inspect})"
      piece_abbr = gets.chomp.upcase
      case piece_abbr
      when 'N'
        puts "Promote to Knight"
        piece = Knight.new
        piece.color = color
        valid = true
      when 'B'
        puts "Promote to Bishop"
        piece = Bishop.new
        piece.color = color
        valid = true
      when 'R'
        puts "Promote to Rook"
        piece = Rook.new
        piece.color = color
        valid = true
      when 'Q'
        puts "Promote to Queen"
        piece = Queen.new
        piece.color = color
        valid = true
      else
        valid = false
        puts "Invalid input, please enter one letter abbreviation (N, B, R, Q), try again..."
      end
    end
    @board[move[1][0]][move[1][1]] = piece
  end # handle_pawn_promotion(move)
  
  # check if path from start to end isn't blocked
  def valid_path?(move)
    piece = @board[move[0][0]][move[0][1]]
    start_pos = move[0]
    end_pos = move[1]
    
    dist = position_distance(move)
    return true if dist == 1

    direction = nil
    if start_pos[1] == end_pos[1]
      direction = 'horizontal'
    elsif start_pos[0] == end_pos[0]
      direction = 'vertical'
    else
      direction = 'diagonal'
    end

    case direction
    when 'horizontal'
      y = start_pos[1]
      start_x = [start_pos[0], end_pos[0]].min + 1
      end_x = [start_pos[0], end_pos[0]].max - 1
      (start_x..end_x).each {|x|
        piece = @board[x][y]
        return false if piece != nil
      }
    when 'vertical'
      x = start_pos[0]
      start_y = [start_pos[1], end_pos[1]].min + 1
      end_y = [start_pos[1], end_pos[1]].max - 1
      (start_y..end_y).each {|y|
        piece = @board[x][y]
        return false if piece != nil
      }
    when 'diagonal'
      x_inc = start_pos[0] < end_pos[0] ? 1 : -1
      y_inc = start_pos[1] < end_pos[1] ? 1 : -1
      start_x = start_pos[0] + (1 * x_inc)
      start_y = start_pos[1] + (1 * y_inc)
      end_x = end_pos[0] - (1 * x_inc)
      end_y = end_pos[1] - (1 * y_inc)
      current_pos = [start_x, start_y]
      while current_pos != end_pos
        x = current_pos[0]
        y = current_pos[1]
        return false if @board[x][y] != nil
        current_pos[0] += x_inc
        current_pos[1] += y_inc
      end
    else
      puts "Fatal Error: valid_path? -- impossible direction encountered: #{direction}"
    end
    
    true
  end # valid_path?(move)

  ##########################
  def move_valid?(move)
    # all moves must be on the board
    return false if !move[0][0].between?(0,7)
    return false if !move[0][1].between?(0,7)
    return false if !move[1][0].between?(0,7)
    return false if !move[1][1].between?(0,7)

    current_player_color = nil
    start_piece = get_piece_at(move[0])

    return false if start_piece == nil
    
    if start_piece.color == 'white'
      current_player_color = 'white'
    else
      current_player_color = 'black'
    end
    
    end_piece = get_piece_at(move[1])

    if start_piece == nil
      return false
    else
      return false if start_piece.color != current_player_color
    end

    # end may not have a piece of the player's color
    if end_piece != nil
      return false if end_piece.color == current_player_color
    end

    # start and end positions match piece's movement rules
    reachable = start_piece.potentially_reachable?(move[0], move[1])
    return false if !reachable

    # path from start to end may not be blocked (except for knights)
    if start_piece.name != 'Knight'
      valid_path = valid_path?(move)
      return false if !valid_path
    end

    # special pawn tests
    if start_piece.name == 'Pawn'
      if start_piece.attack?(move[0], move[1])
        # pawn attack
          # en-passant
          if (move[1][1] == 2 || move[1][1] == 5) && end_piece == nil
            prev_move = moves[-1]
            if prev_move.piece.name == 'Pawn'               &&   # enemy prev move was a pawn
               prev_move.piece.move_count == 1              &&   # enemy pawn's 1st move
               prev_move.move[1][0] == move[1][0]           &&   # enemy's pawn in same column as attacking move dest
               prev_move.move[0][0] == prev_move.move[1][0]      # enemy pawn moved forward (not attack)
              return 'en_passant'
            end
          end
        
          return false if end_piece == nil
          puts ""
        return false if start_piece.color == end_piece.color
        end
      end

    
    # ensure king not moving into check
    if start_piece.name == 'King'
      #      board = Board.new
      #      board.copy(self)
      board = self.clone
      board.move_piece(move)
      if current_player_color == 'white'
        enemy_pieces = board.black_pieces  # enemy from threatened king POV
      else
        enemy_pieces = board.white_pieces  # enemy from threatened king POV
      end

      safe_move = true
      enemy_pieces.each {|el|
        if board.move_valid?([el[1], move[1]])   # using temporary board here (with king's move destination)
          safe_move = false
        end
      }
      return false if !safe_move
    end

    # ensure checked king's player moves out of check
    current_player_king = nil
    if current_player_color == 'white'
      current_player_king = white_king
    else
      current_player_king = black_king
    end
    if current_player_king[0].check
#      board = Board.new
      #      board.copy(self)
      board = self.clone
      board.move_piece(move)
      if current_player_color == 'white'
        enemy_pieces = board.black_pieces  # enemy from threatened king POV
      else
        enemy_pieces = board.white_pieces  # enemy from threatened king POV
      end
      safe_move = true
      enemy_pieces.each {|el|
        if board.move_valid?([el[1], current_player_king[1]])   # using temporary board here (with king's move destination)
          safe_move = false
        end
      }
      return false if !safe_move
    end

    ################################################
    # TODO: check that the square the king jumps is
    #       not in check.
    ################################################
    # check white king-side castle
    if move == [[4,0],[6,0]] && start_piece.name == 'King' && start_piece.color == 'white'
      rook = get_piece_at([7,0])
      if rook != nil && rook.can_castle
        return 'castle' if start_piece.can_castle
      end
    end

    # check white queen-side castle
    if move == [[4,0],[2,0]] && start_piece.name == 'King' && start_piece.color == 'white'
      rook = get_piece_at([0,0])
      if rook != nil && rook.can_castle
        return 'castle' if start_piece.can_castle
      end
    end

    # check black king-side castle
    if move == [[4,7],[6,7]] && start_piece.name == 'King' && start_piece.color == 'black'
      rook = get_piece_at([7,7])
      if rook != nil && rook.can_castle
        return 'castle' if start_piece.can_castle
      end
    end

    # check black queen-side castle
    if move == [[4,7],[2,7]] && start_piece.name == 'King' && start_piece.color == 'black'
      rook = get_piece_at([0,7])
      if rook != nil && rook.can_castle
        return 'castle' if start_piece.can_castle
      end
    end

    if start_piece.name == 'King'
      return false if position_distance(move) > 1
    end
    
    true
  end # def move_valid?(move)


  # returns [king piece, move] or nil  (move to attack king)
  def find_check
    white_piece_array = white_pieces
    black_piece_array = black_pieces
    white_king = nil
    white_piece_array.each {|el|
      white_king = el if el[0].name == 'King'
    }
    black_king = nil
    black_piece_array.each {|el|
      black_king = el if el[0].name == 'King'
    }

    white_king_pos = white_king[1]
    black_king_pos = black_king[1]

    black_piece_array.each {|el|
      move = [el[1], white_king_pos]
      if move_valid?(move)
        white_king[0].can_castle = false
        white_king[0].check = true
        return [white_king[0], move]
      end
    }
    white_king[0].check = false

    white_piece_array.each {|el|
      move = [el[1], black_king_pos]
      if move_valid?(move)
        black_king[0].can_castle = false
        black_king[0].check = true
        return [black_king[0], move]
      end
    }
    black_king[0].check = false

    nil
  end

  
  # returns [ [piece, [coords] ], ... ]
  def white_pieces
    pieces = []
    @board.each_with_index {|col, i|
      col.each_with_index {|piece, j|
        pieces.push([piece, [i, j]]) if piece != nil && piece.color == 'white'
      }
    }
    pieces
  end # white_pieces

  def white_king
    king = nil
    @board.each_with_index {|col, i|
      col.each_with_index {|piece, j|
        king = [piece, [i, j]] if piece != nil && piece.color == 'white' && piece.name == 'King'
      }
    }
    king
  end
  
  # returns [ [piece, [coords] ], ... ]
  def black_pieces
    pieces = []
    @board.each_with_index {|col, i|
      col.each_with_index {|piece, j|
        pieces.push([piece, [i, j]]) if piece != nil && piece.color == 'black'
      }
    }
    pieces
  end # black_pieces

  def black_king
    king = nil
    @board.each_with_index {|col, i|
      col.each_with_index {|piece, j|
        king = [piece, [i, j]] if piece != nil && piece.color == 'black' && piece.name == 'King'
      }
    }
    king
  end
  
  def position_distance(move)
    start_x = move[0][0]
    start_y = move[0][1]
    end_x = move[1][0]
    end_y = move[1][1]
    dx = (end_x - start_x).abs
    dy = (end_y - start_y).abs
    CMath.sqrt(dx*dx + dy*dy).round
  end # position_distance(move)
  

#  private
  def set_piece_display_from_display_board
    @piece_display = ["  8  |    #{@display_board[0][7] ? @display_board[0][7] : '~~'}    |... #{@display_board[1][7] ? @display_board[1][7] : '~~'} ...|    #{@display_board[2][7] ? @display_board[2][7] : '~~'}    |... #{@display_board[3][7] ? @display_board[3][7] : '~~'} ...|    #{@display_board[4][7] ? @display_board[4][7] : '~~'}    |... #{@display_board[5][7] ? @display_board[5][7] : '~~'} ...|    #{@display_board[6][7] ? @display_board[6][7] : '~~'}    |... #{@display_board[7][7] ? @display_board[7][7] : '~~'} ...|",
                      "  7  |... #{@display_board[0][6] ? @display_board[0][6] : '~~'} ...|    #{@display_board[1][6] ? @display_board[1][6] : '~~'}    |... #{@display_board[2][6] ? @display_board[2][6] : '~~'} ...|    #{@display_board[3][6] ? @display_board[3][6] : '~~'}    |... #{@display_board[4][6] ? @display_board[4][6] : '~~'} ...|    #{@display_board[5][6] ? @display_board[5][6] : '~~'}    |... #{@display_board[6][6] ? @display_board[6][6] : '~~'} ...|    #{@display_board[7][6] ? @display_board[7][6] : '~~'}    | ",
                      "  6  |    #{@display_board[0][5] ? @display_board[0][5] : '~~'}    |... #{@display_board[1][5] ? @display_board[1][5] : '~~'} ...|    #{@display_board[2][5] ? @display_board[2][5] : '~~'}    |... #{@display_board[3][5] ? @display_board[3][5] : '~~'} ...|    #{@display_board[4][5] ? @display_board[4][5] : '~~'}    |... #{@display_board[5][5] ? @display_board[5][5] : '~~'} ...|    #{@display_board[6][5] ? @display_board[6][5] : '~~'}    |... #{@display_board[7][5] ? @display_board[7][5] : '~~'} ...|",
                      "  5  |... #{@display_board[0][4] ? @display_board[0][4] : '~~'} ...|    #{@display_board[1][4] ? @display_board[1][4] : '~~'}    |... #{@display_board[2][4] ? @display_board[2][4] : '~~'} ...|    #{@display_board[3][4] ? @display_board[3][4] : '~~'}    |... #{@display_board[4][4] ? @display_board[4][4] : '~~'} ...|    #{@display_board[5][4] ? @display_board[5][4] : '~~'}    |... #{@display_board[6][4] ? @display_board[6][4] : '~~'} ...|    #{@display_board[7][4] ? @display_board[7][4] : '~~'}    | ",
                      "  4  |    #{@display_board[0][3] ? @display_board[0][3] : '~~'}    |... #{@display_board[1][3] ? @display_board[1][3] : '~~'} ...|    #{@display_board[2][3] ? @display_board[2][3] : '~~'}    |... #{@display_board[3][3] ? @display_board[3][3] : '~~'} ...|    #{@display_board[4][3] ? @display_board[4][3] : '~~'}    |... #{@display_board[5][3] ? @display_board[5][3] : '~~'} ...|    #{@display_board[6][3] ? @display_board[6][3] : '~~'}    |... #{@display_board[7][3] ? @display_board[7][3] : '~~'} ...|",
                      "  3  |... #{@display_board[0][2] ? @display_board[0][2] : '~~'} ...|    #{@display_board[1][2] ? @display_board[1][2] : '~~'}    |... #{@display_board[2][2] ? @display_board[2][2] : '~~'} ...|    #{@display_board[3][2] ? @display_board[3][2] : '~~'}    |... #{@display_board[4][2] ? @display_board[4][2] : '~~'} ...|    #{@display_board[5][2] ? @display_board[5][2] : '~~'}    |... #{@display_board[6][2] ? @display_board[6][2] : '~~'} ...|    #{@display_board[7][2] ? @display_board[7][2] : '~~'}    | ",
                      "  2  |    #{@display_board[0][1] ? @display_board[0][1] : '~~'}    |... #{@display_board[1][1] ? @display_board[1][1] : '~~'} ...|    #{@display_board[2][1] ? @display_board[2][1] : '~~'}    |... #{@display_board[3][1] ? @display_board[3][1] : '~~'} ...|    #{@display_board[4][1] ? @display_board[4][1] : '~~'}    |... #{@display_board[5][1] ? @display_board[5][1] : '~~'} ...|    #{@display_board[6][1] ? @display_board[6][1] : '~~'}    |... #{@display_board[7][1] ? @display_board[7][1] : '~~'} ...|",
                      "  1  |... #{@display_board[0][0] ? @display_board[0][0] : '~~'} ...|    #{@display_board[1][0] ? @display_board[1][0] : '~~'}    |... #{@display_board[2][0] ? @display_board[2][0] : '~~'} ...|    #{@display_board[3][0] ? @display_board[3][0] : '~~'}    |... #{@display_board[4][0] ? @display_board[4][0] : '~~'} ...|    #{@display_board[5][0] ? @display_board[5][0] : '~~'}    |... #{@display_board[6][0] ? @display_board[6][0] : '~~'} ...|    #{@display_board[7][0] ? @display_board[7][0] : '~~'}    | ",
                     ]
  end  # def set_piece_display_from_display_board

  def set_display_board_from_board
    (0..7).each {|col|
      (0..7).each {|row|
        @display_board[col][row] = '~~'
        piece = @board[col][row]
        @display_board[col][row] = piece.board_symbol if piece != nil
      }
    }
  end # set_display_board_from_board

end  # class Board


