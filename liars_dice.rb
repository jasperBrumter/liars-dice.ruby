require_relative "liars_setup"

def initialize_game
  #Rules in liars_setup.rb
  puts "Welcome to liar's dice! \n The oldest pirate game in the world. \n Do you know the rules? ( y / n )"
  rules(gets.chomp)

  #initialize player and score hash
  puts "How many CPU opponents would you want this game? (1, 2 or 3 are advised)"
  number_of_opponents = gets.chomp.to_i
  score_hash = players_setup(number_of_opponents)

  puts score_hash


  #initialize player and score hash
  puts "How many dice would you like to play with? (usually 5, but it can be less)"
  dice_number = gets.chomp
  score_hash = number_of_dice(score_hash, dice_number)

  puts score_hash


  play_round(score_hash)
end


def play_round(score_hash)
  puts "Ready to roll your dice? Next round starts in:"
  sleep(1)
  puts "3"
  sleep(1)
  puts "2"
  sleep(1)
  puts "1"
  sleep(1)
  this_round_dice = roll_dice(score_hash)
  puts this_round_dice.inspect




#State of the game:
#Player_x lost 1 dice
#Total amount of dice left
#Player is Out

end
