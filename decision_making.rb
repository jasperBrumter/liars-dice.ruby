def next_player(hash, player)
  i = hash.keys.index(player)
  length = hash.keys.length - 1
  if i == length
    return hash.keys[0]
  else
    return hash.keys[i+1]
  end
end

def make_decision(hash, player, previous)

  end_boolean = false
  total_dice = 0
  hash.each do |key, value|
    total_dice += value.length
  end
  until end_boolean
    puts total_dice
    puts next_player(hash, player)

    end_boolean = true
  end
end

