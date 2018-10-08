def rules(user_input)
  if user_input == "n"
    puts "
    Five dice are used per player with dice cups used for concealment.\n
    Each round, each player rolls a 'hand' of dice under their cup and looks at their hand while keeping it concealed from the other players. The first player begins bidding, announcing any face value and the minimum number of dice that the player believes are showing that value, under all of the cups in the game. Ones are often wild, always counting as the face of the current bid.\n
    Turns rotate among the players in a clockwise order. Each player has two choices during their turn: to make a higher bid, or challenge the previous bid—typically with a call of 'liar'. Raising the bid means either increasing the quantity, or the face value, or both, according to the specific bidding rules used. There are many variants of allowed and disallowed bids; common bidding variants, given a previous bid of an arbitrary quantity and face value, include: \n
     - the player may bid a higher quantity of any particular face, or the same quantity of a higher face (allowing a player to 're-assert' a face value they believe prevalent if another player increased the face value on their bid);\n
     - the player may bid a higher quantity of the same face, or any particular quantity of a higher face (allowing a player to 'reset' the quantity);\n
     - the player may bid a higher quantity of the same face or the same quantity of a higher face (the most restrictive; a reduction in either face value or quantity is never allowed).\n
     - If the current player challenges the previous bid, all dice are revealed. If the bid is valid (at least as many of the face value and any wild aces are showing as were bid), the bidder wins. Otherwise, the challenger wins. The player who loses a round loses one of their dice. The last player to still retain a die (or dice) is the winner. The loser of the last round starts the bidding on the next round. If the loser of the last round was eliminated, the next player starts the new round.\n\n Got it? Great. Let's start playing."

  else
    puts "Great. Let's start playing."
  end
end

def players_setup(user_input)
  until (1..6).include? user_input.to_i
    puts "Not a valid input. Please choose the number of CPU opponents (ideally 1,2,3)"
    user_input = gets.chomp
  end

  player_hash = {
    "player" => 5
  }
  user_input.to_i.times do |x|
    player_hash["CPU#{x+1}"] = 1
  end
  return player_hash
end

def number_of_dice(this_hash, number)
  until (1..5).include? number.to_i
    puts "Not a valid input. Please choose another number of dice for each player (usually 5, could be less)"
    number = gets.chomp
  end
  this_hash.each_key do |key|
    this_hash[key] = number.to_i
  end
  return this_hash
end



def roll_dice(current_player_hash)
  full_dice_hash = {}
  current_player_hash.each do |key, value|
    dice_array = []
    value.to_i.times do
      dice_array.push(rand(1..6))
    end
    full_dice_hash[key] = dice_array
  end

  return full_dice_hash
end
