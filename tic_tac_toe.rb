LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

class Player
  @@all_moves = []
  @@winner = ""
  attr_reader :moves, :move_type, :name

  def initialize(name, move_type)
    @name = name
    @move_type = move_type
    @moves = []
  end

  def move(place)
    if (@@all_moves.include?(place))
      false    
    else
      @@all_moves.push(place)
      self.moves.push(place)
      true  
    end
  end

  def check_winner
    if self.moves.length > 0
      LINES.any?{ |sub_arr| sub_arr.intersection(self.moves) == sub_arr }
    else
      false
    end  
  end

  def self.avaiable_move
    if @@all_moves.length < 9
      true
    else
      false
    end
  end

end

class Board
  attr_reader :grids

  def initialize
    @grids = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def collect_moves(player)
    player.moves.each{ |move| self.grids[move-1] = player.move_type }
    self.display
  end

  def display
    self.grids.each_with_index do |value, index|
      if ((index + 1)%3 != 0 )
        print value.to_s + " | "
      else
        puts value 
        puts "---------" 
      end
    end
  end
end

player_1 = Player.new("Player 1", "X")
player_2 = Player.new("Player 2", "O")
game_board = Board.new

def play(player, game_board)
  player_move = gets.chomp.to_i
  while player_move < 1 || player_move > 9
    puts "#{player.name}: Please enter a valid move"
    player_move = gets.chomp.to_i
  end
  until player.move(player_move)
    puts "#{player.name}: Please choose an empty cell"
    player_move = gets.chomp.to_i
  end 
  game_board.collect_moves(player)
end


avaiable_moves = Player.avaiable_move

9.times do
  puts "Player 1: Enter your move"
  play(player_1, game_board)
  if player_1.check_winner
    puts "Player 1 You won the game congrulations"
    break
  end

  puts "Player 2: Enter your move"
  play(player_2, game_board)
  if player_2.check_winner
    puts "Player 2 You won the game congrulations"
    break
  end

  avaiable_moves = Player.avaiable_move
end

unless(avaiable_moves)
  puts "Its a draw"
end