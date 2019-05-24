# 
# 
# 
# 
require_relative 'piece.rb'
require 'cmath'

class MoveHistoryElement

  def initialize(move, piece)
    @move = move
    @piece = piece
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
  attr_reader :board
  attr_reader :non_pawn_move_count
  
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
  
  def draw
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

    # if Pawn, update move count
    piece = @board[move[1][0]][move[1][1]]
    @board[move[1][0]][move[1][1]].move_count += 1 if piece.name == 'Pawn'

    #############################
    # TODO: handle pawn promotion
    #############################
    handle_pawn_promotion(move) if piece.name == 'Pawn' && move[1][1] == 7
    
    # erase moved piece from old posiiton (on board & display_board)
    @board[move[0][0]][move[0][1]] = nil
    @display_board[move[0][0]][move[0][1]] = nil

    # store move
    @moves.push(MoveHistoryElement.new(move, piece))
    if piece.name == 'Pawn'
      @non_pawn_move_count = 0 # pawn is moved so reset the count to zero
    else
      @non_pawn_move_count += 1
      piece.can_castle = false if piece.name == 'King' || piece.name == 'Knight'
    end
    
    # update display_board
    set_display_board_from_board

    # show game move list
    puts ""
    puts "Move List:"
    @moves.each_with_index {|el, i|
      puts "#{i+1}. #{el.to_string}"
    }
  end # move_piece(move)

  def handle_pawn_promotion(move)
    valid = false
    piece = nil
    while !valid
      puts "Promote Pawn:"
      puts "(N) Knight"
      puts "(B) Bishop"
      puts "(R) Rook"
      puts "(Q) Queen"
      print "Enter piece abbr. to promote pawn to: "
      piece_abbr = gets.chomp.upcase
      case piece_abbr
      when 'N'
        piece = Knight.new
        valid = true
      when 'B'
        piece = Bishop.new
        valid = true
      when 'R'
        piece = Rook.new
        valid = true
      when 'Q'
        piece = Queen.new
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
    move_list = piece.raw_move_list(start_pos)
    
    dist = position_distance(move)
    return true if dist == 1

    tail_pos = end_pos
    while dist > 1
      index = move_list.index {|el|
        (dist = position_distance([el, tail_pos])) == 1
      }
      tail_pos = move_list[index]
      tail_piece = @board[tail_pos[0]][tail_pos[1]]
      return false if tail_piece != nil
    end
    
    true
  end # valid_path?(move)

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
  
  
  private
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
        piece = @board[col][row]
        @display_board[col][row] = piece.board_symbol if piece != nil
      }
    }
  end # set_display_board_from_board

  def position_distance(move)
    start_x = move[0][0]
    start_y = move[0][1]
    end_x = move[1][0]
    end_y = move[1][1]
    dx = (end_x - start_x).abs
    dy = (end_y - start_y).abs
    CMath.sqrt(dx*dx + dy*dy).round
  end # position_distance(move)
  
end  # class Board


