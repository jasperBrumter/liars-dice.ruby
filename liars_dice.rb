require_relative "liars_setup"
require_relative "decision_making"
require "CSV"

def initialize_game
  #Rules in liars_setup.rb
  puts "Welcome to liar's dice! \n The oldest pirate game in the world. \n Do you know the rules? ( y / n )"
  rules(gets.chomp)

  #initialize player and score hash
  puts "How many CPU opponents would you want this game? (1, 2 or 3 are advised)"
  score_hash = players_setup(number_of_opponents = gets.chomp.to_i)

  puts score_hash
  #initialize player and score hash
  puts "How many dice would you like to play with? (usually 5, but it can be less)"
  score_hash = number_of_dice(score_hash, dice_number = gets.chomp)

  puts score_hash

  goes_first = score_hash.keys[rand(0..number_of_opponents)]
  puts "the first player was randomly selected to be #{goes_first}\n\n"
  play_round(score_hash, goes_first)
end

def play_round(score_hash, goes_first)
  puts score_hash
  puts "Ready to roll your dice? Next round starts in:"

  this_round_dice = roll_dice(score_hash)
  puts "your dice are #{this_round_dice["player"].inspect}"


  round_data = get_round_to_player(this_round_dice, goes_first, "1 1")
  puts round_data.inspect
  round_outcome(round_data[0], round_data[1], round_data[2], this_round_dice)
end

def round_outcome(player, decision, bet, hash)
  puts "#{player} said #{decision} to #{bet}"
  bet = bet.split(" ")
  puts hash.inspect
  count = 0
  hash.values.each do |cup|
    cup.each do |dice|
      count += 1 if [bet[1].to_i, 1].include? dice
    end
  end
  puts "there are #{count} #{bet[1]}s"
  verbose_outcome(hash, player, bet, count, decision)
end

def verbose_outcome(hash, player, bet, count, decision)
  case decision
  when "no"
    if count > bet[0].to_i
      puts "that is more than #{bet[0]}, so #{player} loses a dice"
      write_analytics("WRONG", decision, bet[0], count)
    elsif count == bet[0].to_i
      puts "there are exactly #{bet[0]}, #{player} should have said 'yes' !"
      write_analytics("WRONG", decision, bet[0], count)
    else
      puts "that is less than #{bet[0]}, so #{previous_player(hash, player)} loses a dice"
      write_analytics("RIGHT", decision, bet[0], count)
    end
  when "yes"
    if count == bet[0].to_i
      puts "that is exactly the right number of #{bet[1]}s, so #{player} wins a dice!!"
      write_analytics("RIGHT", decision, bet[0], count)
    else
      puts "that was a wrong call, so #{player} loses a dice"
      write_analytics("WRONG", decision, bet[0], count)
    end
  end
end

def write_analytics(right, decision, bet, count)
  csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
  filepath    = 'cpu_analytics.csv'
  CSV.open(filepath, 'a', csv_options) do |csv|
    csv << [right, decision, bet, count]
  end
end




#system clear
#State of the game:
#Player_x lost 1 dice
#Total amount of dice left
#Player is Out

#play_round(new_score_hash, new_goes_first)
