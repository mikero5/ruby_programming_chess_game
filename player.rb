# 
# 
# 
# 

class Player
  attr_reader :color
  
  def initialize(color)
    @color = color.downcase
  end

  def get_move
    done = false
    while !done
      print "#{@color} player move (e.g.   b1,c3) [q: quits, s: save]: "
      input = gets.chomp.downcase
      return input if input == 's' || input == 'q'
      move = input.split(',')
      if move.class == Array && move.length == 2 && move[0].class == String && move[1].class == String
        done = true if move[0][0].between?('a','h') &&
                       move[0][1].between?('1','8') &&
                       move[1][0].between?('a','h') &&
                       move[1][1].between?('1','8')
      else
        puts "Invalid move.class encountered... #{move.class}, length: #{move.length}, move[0].class: #{move[0].class}, move[1].class: #{move[1].class}"
      end
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
