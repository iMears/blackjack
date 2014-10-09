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

	def value
		case @rank
		when "A"
			return 11
		when "K", "Q", "J"
			return 10
		else
			return @rank.to_i
		end
	end

	def to_s
		@rank + @suit
	end
end #end Card

class Play
	def deal(deck)
		if deck.length < 2
			return true
		end
		@hand = []
		@hand << deck.pop
		@hand << deck.pop
		return false
	end #deal

	def isTheDealer(iAmTheDealer)
		@amDealer = iAmTheDealer
	end #isTheDealer


	def hit(deck)
		if deck.length < 1
			return true
		end
		@hand << deck.pop
		return false
	end # hit

	def handValue
		sum = 0
		ace_count = 0
		@hand.each do |x|
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
	end #handValue

	def allCards
		return @hand.join(", ")
	end #allCards

	def firstCard
		return @hand.first
	end #firstCard

end #Play


def getYesNo(question)
	answer = 0
	until answer == "y" || answer == "n"
		puts question.to_s + " y/n"
		answer = gets.chop.downcase.chars.first
	end
	return answer
end


##########   end of definitions   beginning of execution


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
	player = Play.new
	player.isTheDealer(false)
	dealer = Play.new
	dealer.isTheDealer(true)

	dealToPlayerFailed = player.deal(deck)
	if dealToPlayerFailed
		#refresh deck with more cards
	end
	dealToDealerFailed = dealer.deal(deck)
	if dealToDealerFailed
		#refresh deck with more cards
	end

	handTotal = player.handValue
	dealerTotal = dealer.handValue
	if dealerTotal == 21
		puts("DEALER HAS BLACKJACK.. YOU LOSE")
	elsif handTotal == 21
		puts("BLACKJACK YOU WIN")
	else

		3.times do puts " "
		end

		puts ("Your hand is: #{player.allCards}" + "   =>    #{handTotal}")
		puts
		puts ("Dealer is showing: #{dealer.firstCard}")
		3.times do puts " "
		end


		hit = getYesNo("Would you like to hit?")
		while hit == "y"
			puts "\n" * 3
			player.hit(deck)
			handTotal = player.handValue
			if handTotal >= 22
				puts ("		BUSTED!")
				puts
				puts ("your hand was: #{player.allCards}    =>    #{handTotal}")
				break
			end
			puts ("Your hand is: #{player.allCards}    =>    #{handTotal}")
			puts
			puts ("Dealer is showing: #{dealer.firstCard}")
			puts "\n" * 3
			hit = getYesNo("Would you like to hit?")
		end

		if hit == "n" # did not bust
			while dealer.handValue < 17
				dealer.hit(deck)
			end

			dealerTotal = dealer.handValue

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
				puts("OOPS ERROR!")
			end
			puts
			puts ("Your hand was: #{player.allCards}    =>    #{handTotal}")
			puts
			puts ("Dealers hand was: #{dealer.firstCard}    =>    #{dealerTotal}")
		end
		puts "\n" * 3
		play = getYesNo("Would you like to play again?")
	end
end


