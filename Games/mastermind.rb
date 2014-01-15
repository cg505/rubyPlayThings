require "colored"

class GameBoard
	def initialize
		@solved = false;
		@guesses = [];
		@solution = [rand(6) + 1, rand(6) + 1, rand(6) + 1, rand(6) + 1]
	end
	attr_accessor :solved
	def new_guess(guess)
		red = 0
		white = 0
		solution_used = [false, false, false, false]
		guess_used = [false, false, false, false]
		for i in 0..3
			if (guess[i] == @solution[i])
				red += 1
				solution_used[i] = true
				guess_used[i] = true
				if (red == 4)
					@solved = true;
				end
			end
		end
		for i in 0..3
			for j in 0..3
				if (guess[i] == @solution[j]) && !solution_used[j] && !guess_used[i]
					solution_used[j] = true
					guess_used[i] = true
					white += 1
				end
			end
		end
		return [guess, [red, white]]
	end
	def add_guess(guess_accuracy)
		@guesses << guess_accuracy
	end
	def print_board
		print "+----+\n"
		@guesses.each do |guess|
			print_line(guess)
		end
		print "+----+\n"
	end
	def print_line(guess)
		print "|"
		guess[0].each do |x|
			case x
			when 1
				print "*".red
			when 2
				print "*".magenta
			when 3
				print "*".yellow
			when 4
				print "*".green
			when 5
				print "*".blue
			when 6
				print "*".cyan
			end
		end
		print "|"
		guess[1][0].times do;print "+".red;end;
		guess[1][1].times do;print "+".white;end;
		print "\n"
	end
	def print_solution
		print "|"
		@solution.each do |pin|
			case pin
			when 1
				print "*".red
			when 2
				print "*".magenta
			when 3
				print "*".yellow
			when 4
				print "*".green
			when 5
				print "*".blue
			when 6
				print "*".cyan
			end
		end
		print "|\n"
		print "+----+"
	end
end
def play
	`clear`
	puts ("Mastermind\n----------\nWriten By Sam Mercier\n\n")
	game = GameBoard.new
	count = 0
	begin
		game.print_board
		print "Guess (1 = red, 2 = magenta, 3 = yellow, 4= green, 5 = blue, 6 = cyan) "
		in_guess = gets.chomp
		guess = []
		for x in 0..3
			guess[x] = in_guess[x].to_i
			x += 1
		end
		proc_guess = game.new_guess(guess)
		game.add_guess(proc_guess)
		count += 1
	end while (!game.solved && count < 10)
	game.print_board
	game.print_solution
	if game.solved
		puts "\nGood Job You Win!\n"
	elsif
		puts "\nYou Loose Looser\n"
	end
end
begin
	puts ("Mastermind\n----------\nWriten By Sam Mercier\n\n")
	puts ("Would you like to play? \(y/N\) ")
	cont = gets.chomp
	play
end while (cont == 'y')
