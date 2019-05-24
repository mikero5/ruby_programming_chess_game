# 
# 
# 
# 

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

  def initialize
    @name = 'Rook'
    @color = ''
  end

  def board_symbol
    "R#{@color[0].downcase}"
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
  attr_accessor :can_castle
  
  def initialize
    @name = 'Knight'
    @color = ''
    @can_castle = true
  end

  def board_symbol
    "N#{@color[0].downcase}"
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

  def initialize
    @name = 'King'
    @color = ''
    @can_castle = true
  end

  def board_symbol
    "K#{@color[0].downcase}"
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
