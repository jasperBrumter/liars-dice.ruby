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


  #initialize player and score hash
  puts "How many dice would you like to play with? (usually 5, but it can be less)"
  score_hash = number_of_dice(score_hash, dice_number = gets.chomp)


  goes_first = score_hash.keys[rand(0..number_of_opponents)]
  puts "the first player was randomly selected to be #{goes_first}\n\n"

  play_round(score_hash, goes_first)
end

def play_round(score_hash, goes_first)
  puts "Ready to roll your dice? Next round starts in:"

  this_round_dice = roll_dice(score_hash)
  round_summary_table(this_round_dice)
  puts "your dice are #{this_round_dice["player"].inspect}"


  round_data = get_round_to_player(this_round_dice, goes_first, "1 1")
  round_summary_table(this_round_dice)
  round_outcome(round_data[0], round_data[1], round_data[2], this_round_dice)
end

def round_outcome(player, decision, bet, hash)
  bet = bet.split(" ")
  system "clear"
  round_summary_table(hash)
  puts "#{player} said #{decision} to #{bet[0]} #{bet[1]}s"
  count = 0
  hash.each do |player, cup|
    his_count = 0
    cup.each do |dice|
      his_count += 1 if [bet[1].to_i, 1].include? dice
      count += 1 if [bet[1].to_i, 1].include? dice
    end
    puts "#{player} has #{his_count} #{bet[1]}s    :   #{hash[player]}"
    puts "..."
    sleep(1)
  end
  puts "In total there are #{count} #{bet[1]}s"
  next_data = verbose_outcome(hash, player, bet, count, decision)
  possible_next_player = next_player(hash, next_data[0])

  hash.keys.each do |players|
    hash[players] = hash[players].length
    hash[players] += next_data[1] if players == next_data[0]
    hash[players] = 5 if hash[players] > 5
    hash.delete(players) if hash[players] == 0
  end

  if hash.key?(next_data[0])
    play_round(hash, next_data[0]) unless game_done?(hash)
  else
    play_round(hash, possible_next_player) unless game_done?(hash)
  end

  puts "Game finished !"
end

def verbose_outcome(hash, player, bet, count, decision)
  sleep(2)
  system "clear"
  case decision
  when "no"
    if count > bet[0].to_i
      puts "that is more than #{bet[0]}, so #{player} loses a dice"
      write_analytics("WRONG", decision, bet[0], count)
      return[player, -1]
    elsif count == bet[0].to_i
      puts "there are exactly #{bet[0]}, #{player} should have said 'yes' !"
      write_analytics("WRONG", decision, bet[0], count)
      return[player, -1]
    else
      puts "that is less than #{bet[0]}, so #{previous_player(hash, player)} loses a dice"
      write_analytics("RIGHT", decision, bet[0], count)
      return[previous_player(hash, player), -1]
    end
  when "yes"
    if count == bet[0].to_i
      puts "that is exactly the right number of #{bet[1]}s, so #{player} wins a dice!!"
      write_analytics("RIGHT", decision, bet[0], count)
      return [player, +1]
    else
      puts "that was a wrong call, so #{player} loses a dice"
      write_analytics("WRONG", decision, bet[0], count)
      return [player, -1]
    end
  end
  round_summary_table(hash)
end

def write_analytics(right, decision, bet, count)
  csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
  filepath    = 'cpu_analytics.csv'
  CSV.open(filepath, 'a', csv_options) do |csv|
    csv << [right, decision, bet, count]
  end
end

def game_done?(hash)
  if hash.keys.length == 1
    return true
  else
    return false
  end
end

def round_summary_table(hash)
  puts "-----------------------"
  total = 0
  hash.keys.each do |s|
    puts "#{s} : #{hash[s].length} dice"
    total += hash[s].length
  end
  puts "-----------------------"
  puts "Total : #{total} dice"
  puts "-----------------------"
end




#system clear
#State of the game:
#Player_x lost 1 dice
#Total amount of dice left
#Player is Out

#play_round(new_score_hash, new_goes_first)
