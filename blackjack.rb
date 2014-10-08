class Card
	# attr_reader :rank, :suit

	SUITS = %w(♠ ♥ ♦ ♣)
	RANKS = %w(2 3 4 5 6 7 8 9 10 J Q K A)

	def initialize(rank, suit)
		@rank = rank
		@suit = suit
	end

	def is_ace?
		if @rank == "A"
			return true
		else 
			return false
		end
	end





#change to use case statement


	def value
		if @rank == "K" 
			return 10
		elsif @rank == "Q"
			return 10
		elsif @rank == "J"
			return 10
		elsif @rank == "A"
			return 11
		else 
			return @rank.to_i
		end
	end

	

	def to_s
		@rank + @suit
	end
end


def getYesNo(question)
	answer = 0
	until answer == "y" || answer == "n"
		puts question.to_s + " y/n"
		answer = gets.chop.downcase.chars.first
	end
	return answer
end


def get_hand_total(player)
	sum = 0
	ace_count = 0
	player.each do |x|
		if x.is_ace? == true
			ace_count += 1
		end
		sum += x.value
	end
	while ace_count > 0 && sum >21
		sum -= 10
		ace_count -= 1
	end
	return sum
end


# initialze the dec.  52 cards
deck = []
Card::SUITS.each do |x| 
	Card::RANKS.each do |y|
		deck << Card.new(y,x)
	end 
end

puts "\n" * 3
play = getYesNo("Play blackjack? ")
deck.shuffle!

while play == "y"
	# do I have enough cards to play one hand

	if deck.length < 10
		puts ("shuffling...\n" * 25)
		deck = []
		Card::SUITS.each do |x| 
			Card::RANKS.each do |y|
				deck << Card.new(y,x)
			end 
		end
		deck.shuffle!
	end

	#deal to the player and the dealer
	player = []
	player << deck.pop
	player << deck.pop 

	dealer = []
	dealer << deck.pop
	dealer << deck.pop

	
	handTotal = get_hand_total(player)
	dealerTotal = get_hand_total(dealer)
	if dealerTotal == 21
		puts("DEALER HAS BLACKJACK.. YOU LOSE")
	elsif handTotal == 21
		puts("BLACKJACK YOU WIN")
	else


		3.times do puts " "
		end
		puts ("Your hand is: #{player.join(", ")}" + "   =>    #{handTotal}")
		puts
		puts ("Dealer is showing: #{dealer.first}")
		3.times do puts " "
		end


		hit = getYesNo("Would you like to hit?")
		while hit == "y"
			puts "\n" * 3
			player << deck.pop
			handTotal = get_hand_total(player)
			if handTotal >= 22
				puts ("		BUSTED!")
				puts
				puts ("your had was: #{player.join(", ")}    =>    #{handTotal}")
				break
			end
			puts ("Your hand is: #{player.join(", ")}    =>    #{handTotal}")
			puts
			puts ("Dealer is showing: #{dealer.first}")
			puts "\n" * 3
			hit = getYesNo("Would you like to hit?")
		end

		if hit == "n" # did not bust
			while get_hand_total(dealer) < 17
				dealer << deck.pop
			end

			dealerTotal = get_hand_total(dealer)

			puts "\n" * 3

			if dealerTotal > 21 
				puts ("		YOU WIN.. DEALER BUSTED!")
			elsif handTotal == dealerTotal
				puts("		PUSH!")
			elsif handTotal > dealerTotal
				puts("		YOU WIN!")
			elsif handTotal < dealerTotal
				puts("		YOU LOSE")
			else 
				puts("		YOU WIN")
			end
			puts
			puts ("Your hand was: #{player.join(", ")}    =>    #{handTotal}")
			puts
			puts ("Dealers hand was: #{dealer.join(", ")}    =>    #{dealerTotal}")
		end 
		puts "\n" * 3
		play = getYesNo("Would you like to play again?")
	end
end


