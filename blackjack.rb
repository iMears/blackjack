class Card
	# attr_reader :rank, :suit

	SUITS = %w(♠ ♥ ♦ ♣)
	RANKS = %w(2 3 4 5 6 7 8 9 J Q K A)

	def initialize(rank, suit)
		@rank = rank
		@suit = suit
	end

	def values
		if @rank == "K" 
			return [10]
		elsif @rank == "Q"
			return [10]
		elsif @rank == "J"
			return [10]
		elsif @rank == "A"
			return [1, 11]
		else 
			return [@rank.to_i]
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

def GetHandTotal(player)
	sum = 0
	player.each do |x|
		sum += x.values[0]
	end
	return sum
end

deck = []
Card::SUITS.each do |x| 
	Card::RANKS.each do |y|
		deck << Card.new(y,x)
	end 
end

deck.shuffle!

player = []
player << deck.pop
player << deck.pop 

puts ("your hand is: #{player.join(", ")}")
handTotal = GetHandTotal(player)
puts ("your total is: #{handTotal}")

hit = getYesNo("would you like to hit?")
while hit == "y"
	player << deck.pop
	handTotal = GetHandTotal(player)
	if handTotal >= 22
		puts ("sorry you busted")
		break
	end
	puts("your hand is: #{player.join(", ")}")
	hit = getYesNo("would you like to hit?")
end


dealer = []
dealer << deck.pop
dealer << deck.pop


puts ("your hand was: #{player.join(", ")}")
puts ("dealers hand was: #{dealer.join(", ")}")

