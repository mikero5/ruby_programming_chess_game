# 
# 
# 
# 

class Player
  attr_reader :color
  
  def initialize(color)
    @color = color.downcase
  end

  # TODO: add prompt option to save/load game
  def get_move
    done = false
    while !done
      print "#{@color} player move (e.g.   b1,c3): "
      move = gets.chomp.split(',')
      done = true if move[0][0].between?('a','h') &&
                     move[0][1].between?('1','8') &&
                     move[1][0].between?('a','h') &&
                     move[1][1].between?('1','8')
      puts "Invalid input, please enter move as 'start position,end position' (with no spaces) using chess notation, try again..." unless done
    end
    array_move = convert_move_to_array_indices(move)
#    array_move
  end

  def convert_move_to_array_indices(alpha_move)
    x = alpha_move[0][0].ord - 'a'.ord
    y = alpha_move[0][1].to_i-1
    start = [x, y]
    x = alpha_move[1][0].ord - 'a'.ord
    y = alpha_move[1][1].to_i-1
    last = [x, y]
    [start, last]
  end
end
