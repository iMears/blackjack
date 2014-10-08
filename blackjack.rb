def blackjack
	prompt
end

def prompt
	puts("Hello, would you like to play a game of blackjack? Enter: 'yes' or 'no'")
	play = gets
	play = play.chomp.downcase
	if play == "yes"
		game_plan
	elsif play == "no"
		puts("Ok, come back when you're ready to play!")
		break
	else
		puts("You entered and invaled option. Enter 'yes' to keep playing, 'no' to quit")
		keep_playing = gets
		keep_playing = keep_playing.chomp.downcase
		if keep_playing == "no"
			break
		else keep_playing == "yes"
			blackjack
		end

	end
end

def Game_plan
	wants_to_play == true
	hand = []
	total = first_move(hand)
	wants_to_play = hit_me(hand)
	if wants_to_play == true 
		first_move
	end
end

def first_move 
	deal(hand)
	deal(hand)
	total(hand)
end

def deal(hand)
	card = rand(13)
	puts("You have been dealt a card with the value #{card}")
	hand << card
end

def total(hand)
	total = 0
	hand.each do |count|
		total += count
	end
	puts("The sum of the cards you have been dealt is #{total}")
	total
end

def hit_me_hand(hand)
	puts("Would you like to 'hit' or 'stick'?")
	yes_or_no = gets
	yes_or_no = yes_or_no.chomp.downcase
	if yes_or_no == "stick" && total < 21
		puts("Sorry! The sum of the cards you have been dealt is less than 21. You loose!")
	else
		deal(hand)
		total(hand)
	end
end

max_hits = 5
hits = 0
	loop do
		break if hits > max_hits
		puts("would you like to hit or stick?")
		else
		hits += 1
	end 
end



