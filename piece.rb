# 
# 
# 
#


# 
# red: 31
# green: 32
# yellow: 33
# blue: 34
# purple: 35
# Teal: 36
# gray: 37
# red bg: 41 *
# green bg: 42 *
# yellow bg: 43
# blue bg: 44 *
# purple bg: 45
# Teal bg: 46
# gray bg: 47
# 

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

###############################
class Pawn
  attr_accessor :name
  attr_accessor :color
  attr_accessor :move_count
#  attr_accessor :first_move

  def initialize
    @name = 'Pawn'
    @color = ''
    @move_count = 0
#    @first_move = true
  end

  def board_symbol
    "P#{@color[0].downcase}"
    @color == 'white' ? colorize("Pn", 31) : colorize("Pn", 32)
#    white_symbol = "\u2659"
#    black_symbol = "\u265F"
#    @color == 'white' ? " #{black_symbol.encode('utf-8')}" : " #{white_symbol.encode('utf-8')}"
  end

  def raw_move_list(position)
    move_list = []
    x = position[0]
    y = position[1]

    if @color.downcase == 'white'
      move_list.push([x, y+2]) if @move_count == 0
      move_list.push([x, y+1])
      move_list.push([x-1, y+1])
      move_list.push([x+1, y+1])
    else
      move_list.push([x, y-2]) if @move_count == 0
      move_list.push([x, y-1])
      move_list.push([x-1, y-1])
      move_list.push([x+1, y-1])
    end

    move_list
  end

  def potentially_reachable?(start_pos, end_pos)
    move_list = raw_move_list(start_pos)
    return move_list.include?(end_pos)
  end

  def attack_move_list(position)
    move_list = []
    x = position[0]
    y = position[1]

    if @color.downcase == 'white'
      move_list.push([x-1, y+1])
      move_list.push([x+1, y+1])
    else
      move_list.push([x-1, y-1])
      move_list.push([x+1, y-1])
    end

    move_list
  end

  def attack?(start_pos, end_pos)
    move_list = attack_move_list(start_pos)
    return move_list.include?(end_pos)
  end

end  # class Pawn

###############################
class Rook
  attr_accessor :name
  attr_accessor :color
  attr_accessor :can_castle

  def initialize
    @name = 'Rook'
    @color = ''
    @can_castle = true
  end

  def board_symbol
    "R#{@color[0].downcase}"
    @color == 'white' ? colorize("Rk", 31) : colorize("Rk", 32)
#    white_symbol = "\u2656"
#    black_symbol = "\u265C"
#    @color == 'white' ? " #{black_symbol.encode('utf-8')}" : " #{white_symbol.encode('utf-8')}"
  end

  def raw_move_list(position)
    move_list = []
    x = position[0]
    y = position[1]

    (1..7).each {|i|
      move_list.push([x, y+i])
      move_list.push([x, y-i])
      move_list.push([x+i, y])
      move_list.push([x-i, y])
    }

    move_list
  end
  
  def potentially_reachable?(start_pos, end_pos)
    move_list = raw_move_list(start_pos)
    return move_list.include?(end_pos)
  end

end # class Rook

###############################
class Knight
  attr_accessor :name
  attr_accessor :color
  
  def initialize
    @name = 'Knight'
    @color = ''
  end

  def board_symbol
    "N#{@color[0].downcase}"
    @color == 'white' ? colorize("Nt", 31) : colorize("Nt", 32)
#    white_symbol = "\u2658"
#    black_symbol = "\u265E"
#    @color == 'white' ? " #{black_symbol.encode('utf-8')}" : " #{white_symbol.encode('utf-8')}"
  end

  def raw_move_list(position)
    move_list = []
    x = position[0]
    y = position[1]

    move_list.push([x-1, y-2])
    move_list.push([x-1, y+2])
    move_list.push([x+1, y-2])
    move_list.push([x+1, y+2])
    move_list.push([x-2, y-1])
    move_list.push([x-2, y+1])
    move_list.push([x+2, y-1])
    move_list.push([x+2, y+1])

    move_list
  end
  
  def potentially_reachable?(start_pos, end_pos)
    move_list = raw_move_list(start_pos)
    return move_list.include?(end_pos)
  end

end # class Knight

###############################
class Bishop
  attr_accessor :name
  attr_accessor :color

  def initialize
    @name = 'Bishop'
    @color = ''
  end

  def board_symbol
    "B#{@color[0].downcase}"
    @color == 'white' ? colorize("Bp", 31) : colorize("Bp", 32)
#    white_symbol = "\u2657"
#    black_symbol = "\u265D"
#    @color == 'white' ? " #{black_symbol.encode('utf-8')}" : " #{white_symbol.encode('utf-8')}"
  end

  def raw_move_list(position)
    move_list = []
    x = position[0]
    y = position[1]

    (1..7).each {|i|
      move_list.push([x+i,  y+i])
      move_list.push([x+i,  y-i])
      move_list.push([x-i,  y+i])
      move_list.push([x-i,  y-i])
    }
    
    move_list
  end
  
  def potentially_reachable?(start_pos, end_pos)
    move_list = raw_move_list(start_pos)
    return move_list.include?(end_pos)
  end

end # class Bishop

###############################
class Queen
  attr_accessor :name
  attr_accessor :color

  def initialize
    @name = 'Queen'
    @color = ''
  end

  def board_symbol
    "Q#{@color[0].downcase}"
    @color == 'white' ? colorize("Qn", 31) : colorize("Qn", 32)
#    white_symbol = "\u2655"
#    black_symbol = "\u265B"
#    @color == 'white' ? " #{black_symbol.encode('utf-8')}" : " #{white_symbol.encode('utf-8')}"
  end

  def raw_move_list(position)
    move_list = []
    x = position[0]
    y = position[1]

    (1..7).each {|i|
      # from Bishop
      move_list.push([x+i,  y+i])
      move_list.push([x+i,  y-i])
      move_list.push([x-i,  y+i])
      move_list.push([x-i,  y-i])
      # from Rook
      move_list.push([x, y+i])
      move_list.push([x, y-i])
      move_list.push([x+i, y])
      move_list.push([x-i, y])
    }
    
    move_list
  end

  def potentially_reachable?(start_pos, end_pos)
    move_list = raw_move_list(start_pos)
    return move_list.include?(end_pos)
  end

end # class Queen

###############################
class King
  attr_accessor :name
  attr_accessor :color
  attr_accessor :can_castle
  attr_accessor :check

  def initialize
    @name = 'King'
    @color = ''
    @can_castle = true
    @check = false
  end

  def board_symbol
    "K#{@color[0].downcase}"
    @color == 'white' ? colorize("Kg", 31) : colorize("Kg", 32)
#    white_symbol = "\u2654"
#    black_symbol = "\u265A"
#    @color == 'white' ? " #{black_symbol.encode('utf-8')}" : " #{white_symbol.encode('utf-8')}"
  end

  def raw_move_list(position)
    move_list = []
    x = position[0]
    y = position[1]

    move_list.push([x-1, y-1])
    move_list.push([x-1, y])
    move_list.push([x-1, y+1])
    move_list.push([x, y-1])
    move_list.push([x, y+1])
    move_list.push([x+1, y-1])
    move_list.push([x+1, y])
    move_list.push([x+1, y+1])

    move_list
  end
  
  def potentially_reachable?(start_pos, end_pos)
    move_list = raw_move_list(start_pos)
    return move_list.include?(end_pos)
  end

end # class King
