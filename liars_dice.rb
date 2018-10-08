require_relative "liars_setup"

def initialize_game
  #Rules in liars_setup.rb
  puts "Welcome to liar's dice! \n The oldest pirate game in the world. \n Do you know the rules? ( y / n )"
  rules(gets.chomp)

  #initialize player and score hash
  puts "How many CPU opponents would you want this game? (1, 2 or 3 are advised)"
  number_of_opponents = gets.chomp.to_i
  system "clear"
  score_hash = players_setup(number_of_opponents)

  puts score_hash


  #initialize player and score hash
  puts "How many dice would you like to play with? (usually 5, but it can be less)"
  dice_number = gets.chomp
  system "clear"
  score_hash = number_of_dice(score_hash, dice_number)

  puts score_hash

  goes_first = score_hash.keys[rand(0..number_of_opponents)]
  puts "the first player was randomly selected to be #{goes_first}\n\n"
  play_round(score_hash, goes_first)
end


def play_round(score_hash, goes_first)
  puts "Ready to roll your dice? Next round starts in:"
  puts "First player is #{goes_first}\n\n"

  this_round_dice = roll_dice(score_hash)
  puts "your dice are #{this_round_dice["player"].inspect}"




#State of the game:
#Player_x lost 1 dice
#Total amount of dice left
#Player is Out

end
