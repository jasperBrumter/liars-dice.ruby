def next_player(hash, player)
  i = hash.keys.index(player)
  length = hash.keys.length - 1
  if i == length
    return hash.keys[0]
  else
    return hash.keys[i+1]
  end
end

def get_round_to_player(hash, this_player, bet)
  if this_player == "player"
    puts "\nNow it is your turn, previous bet was #{bet}s"
  else this_player == "player"
    puts "\n\n\nplayer #{this_player} is thinking..."
    sleep(4)
    decision = make_decision(hash, this_player, bet)
    #makes decision
    #if decision = YES or NO, end

    #if decision is bet, continue
    puts "#{this_player}'s dice are #{hash[this_player]}"
    puts "decision is #{decision}"
    get_round_to_player(hash, next_player(hash, this_player), decision)
  end
end

def make_decision(hash, this_player, previous)
  total_dice = 0
  str_answer = ""
  this_bet = previous.split(" ")
  hash.each do |key, value|
    total_dice += value.length
  end


    str_answer += (rand(1..2) + this_bet[0].to_i).to_s
    str_answer += "  #{rand(2..6)}"
    return str_answer
end

#
#   until end_boolean
#     #if return BET MORE
#     puts total_dice
#     puts next_player(hash, player)

#     #if return NO
#     end_boolean = true

#     #if return YES
#     end_boolean = true
#   end
# end

