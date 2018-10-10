def valid_input?(previous, input)
  return true if ["no", "yes"].include? input.downcase
  previous = previous.split(" ")
  input = input.split(" ")

  if (previous[0].to_i < input[0].to_i) && (2..6).include?(input[1].to_i)
    return true
  elsif (previous[0].to_i == input[0].to_i) && (previous[1].to_i..6).include?(input[1].to_i) && input[1].to_i > previous[1].to_i
    return true
  else
    return false
  end
end

def next_player(hash, player)
  i = hash.keys.index(player)
  length = hash.keys.length - 1
  if i == length
    return hash.keys[0]
  else
    return hash.keys[i+1]
  end
end

def previous_player(hash, player)
  i = hash.keys.index(player)
  length = hash.keys.length - 1
  if i == 0
    return hash.keys[length]
  else
    return hash.keys[i-1]
  end
end

def get_round_to_player(hash, this_player, bet)
  #player makes his own decision
  if this_player == "player"
    puts "\nNow it is your turn, previous bet was #{bet}"

    next_input = gets.chomp
    until valid_input?(bet, next_input)
      puts "That was not a valid input, remember to bet a higher number of dice"
      next_input = gets.chomp
    end
    #end if decision is yes or no
    if ["no", "yes"].include? next_input
      return [this_player, next_input, bet]
    end
    #if not, continue playing
    get_round_to_player(hash, next_player(hash, "player"), next_input)

  #computers makes decision
  else
    puts "\n\n\nplayer #{this_player} is thinking..."
    sleep(4)
    decision = make_decision(hash, this_player, bet)
    puts "#{this_player}'s decision is #{decision}"

    #if decision = YES or NO, end
    if ["no", "yes"].include? decision
      return [this_player, decision, bet]
    end

    #if decision is bet, continue with next player
    get_round_to_player(hash, next_player(hash, this_player), decision)
  end
end

def make_decision(hash, this_player, previous)
  #initialize previous and next decision
  str_answer = ""
  previous_bet = previous.split(" ")
  #-----------------

  #calculate total number of dice still in game
  total_dice = 0
  hash.each do |key, value|
    total_dice += value.length
  end
  #-----------------

  #calculate number of THAT dice in player's hands
  number_of = 0
  hash[this_player].each do |x|
    if x.to_i == 1 or x.to_i == previous_bet[1]
      number_of += 1
    end
  end
  #-----------------

  #calculate normal distribution
  other_dice = total_dice - hash[this_player].length
  normal_distribution = other_dice / 3.0 + number_of
  #-----------------
  if previous_bet[0].to_i > other_dice + number_of
    return "no"
  elsif previous_bet[0].to_i > 2 * normal_distribution && rand(1..10) > 2
    return "no"
  elsif previous_bet[0].to_i > 1.5 * normal_distribution && rand(1..10) > 5
    return "no"
  elsif previous_bet[0].to_i > 1.2 * normal_distribution && rand(1..10) == 1
    return "yes"
  elsif previous_bet[0].to_i > normal_distribution && number_of <= 1 && rand(1..10) > 3
    return "no"
  elsif previous_bet[0].to_i + 2 > normal_distribution && rand(1..10) > 3
    str_answer += (rand(1..2) + previous_bet[0].to_i).to_s
    str_answer += "  #{rand(2..6)}"
    return str_answer
  elsif previous_bet[0].to_i + 5 > normal_distribution && rand(1..10) > 2
    str_answer += (rand(1..4) + previous_bet[0].to_i).to_s
    str_answer += "  #{rand(2..6)}"
    return str_answer
  elsif rand(1..10)
    str_answer += (rand(3..6) + previous_bet[0].to_i).to_s
    str_answer += "  #{rand(2..6)}"
    return str_answer
  end
end
