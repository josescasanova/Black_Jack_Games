puts "Let's play some Black Jack!"

 
def calculate_cards(hand) #[["C", "2"], ["S", "J"]]
  arr = hand.map { |e| e[1] }

  total = 0
  arr.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0
      total += 10
    else
      total += value.to_i
    end
  end
  
  arr.select { |value| value == "A"}.count.times do
    if total > 21
      total -= 10
    end
  end

  total
end

suites = ["C", "S", "H", "D"]
cards = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]
deck = suites.product(cards)
deck.shuffle!

player_hand = []
dealer_hand = []

player_hand << deck.pop
dealer_hand << deck.pop
player_hand << deck.pop
dealer_hand << deck.pop

dealertotal = calculate_cards(dealer_hand)
playertotal = calculate_cards(player_hand)


puts "The dealer's hand is #{dealer_hand[0]} and #{dealer_hand[1]}, for a total of #{dealertotal}"
puts "Your hand is #{player_hand[0]} and #{player_hand[1]}, for a total of #{playertotal}"
puts ""

if playertotal == 21
  puts "Congratulations! You win!"
  exit
end

while playertotal < 21
  puts "Do you want to hit or stay? Press, 1, for hit and, 2, for stay."
  hit_or_stay = gets.chomp

  if hit_or_stay == "2"
    puts "You have decided to stay."
    puts "Your hand is #{player_hand}, for a total of #{playertotal}"
    break
  end
  
  if !hit_or_stay.include?("1" || "2") 
    puts "Please press either 1 or 2"
    next
  end

  if hit_or_stay == "1"
    player_hand << deck.pop
    puts "Your hand is #{player_hand}"
    playertotal = calculate_cards(player_hand)
    puts "Your total is, #{playertotal}"
  end

  if playertotal == 21
    puts "You win!"
  elsif playertotal > 21
    puts "You lose."
  end

end

if dealertotal == 21
  puts "The dealer wins!"
  exit
end

while dealertotal < 21
  puts "Does the dealer want hit or stay? Press, 1, for hit and, 2, for stay."
  hit_or_stay = gets.chomp

  if hit_or_stay == "2"
    puts "The dealer has decided to stay."
    calculate_cards(dealer_hand)
    puts "The dealer's hand is #{dealer_hand}, for a total of #{dealertotal}"
    break
  end
  
  if !hit_or_stay.include?("1" || "2") 
    puts "Please press either 1 or 2"
    next
  end

  if hit_or_stay == "1"
    dealer_hand << deck.pop
    puts "Your hand is #{dealer_hand}"
    dealertotal = calculate_cards(dealer_hand)
    puts "Your total is, #{dealertotal}"
  end

  if dealertotal == 21
    puts "The dealer wins!"
  elsif dealertotal > 21
    puts "The dealer loses."
  end
end

if playertotal > dealertotal
  puts "The player wins!"
else
  dealertotal > playertotal
  puts "The dealer wins."
end
