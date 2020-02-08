# !/usr/bin/env ruby

board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
WIN_POSSIBILITY = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
].freeze
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]}"
  puts '-----------'
  puts " #{board[3]} | #{board[4]} | #{board[5]}"
  puts '-----------'
  puts " #{board[6]} | #{board[7]} | #{board[8]}"
end

def validate_name(name)
  if name == ''
    false
  else
    name != ' '
  end
end

puts 'Welcome to Tic-Tac-Toe!'
puts 'Player 1 - Please enter your name:'
player_one = gets.chomp

if validate_name(player_one)

else
  puts 'Sorry! Invalid name. Try again.'
  puts 'Player 1 - please enter your name: '
  player_one = gets.chomp
  if validate_name(player_one)
    puts 'Okay, good name!'
  else
    puts "Your name is invalid again. We'll just call you 'Player 1'"
    player_one = 'Player 1'.freeze
  end
end
puts ''

puts 'Player 2 - please enter your name'
player_two = gets.chomp

if validate_name(player_two)

else
  puts 'Sorry! Invalid name. Try again.'
  puts 'Player 2 - please enter your name: '
  player_two = gets.chomp
  if validate_name(player_two)
    puts 'Okay, good name!'
  else
    puts "Your name is invalid again. We'll just call you 'Player 2'"
    player_two = 'Player 2'.freeze
  end
end
puts ''

puts "#{player_one} you will play as X"
puts "#{player_two} you are gonna be O"
puts ''

display_board(board)
puts ''

def convert_input(input)
  input.to_i - 1
end

def postion_taken(board, index)
  if board[index] == '^[1-9]'
    false
  elsif board[index] == 'X'
    true
  elsif board[index] == 'O'
    true

  end
end

def valid_move(board, index)
  if !index.between?(0, 8)
    puts 'Invalid Move.'
  elsif postion_taken(board, index)
    puts 'Invalid Move.'
  else
    true
  end
end

def win(board)
  WIN_POSSIBILITY.each do |win_pos|
    win_pos_one = win_pos[0]
    win_pos_two = win_pos[1]
    win_pos_three = win_pos[2]

    pos_one = board[win_pos_one]
    pos_two = board[win_pos_two]
    pos_three = board[win_pos_three]

    if pos_one == 'X' && pos_two == 'X' && pos_three == 'X' || pos_one == 'O' && pos_two == 'O' && pos_three == 'O'
      return win_pos
    end
  end
  false
end

def winner(board)
  if win(board).class == Array
    win_player = win(board)
    win_token = win_player[0]
    board[win_token]
  else
    draw(board)
  end
end

def game_end(board)
  win(board) || draw(board)
end

def play(board, player_one = nil, player_two = nil)
  turn(board) until game_end(board)

  if winner(board) == 'X'
    puts "#{player_one} is the winner"
  elsif winner(board) == 'O'
    puts "#{player_two} is the winner"

  else
    puts 'It a Draw!'
  end
end

def board_full(board)
  element = board.all? do |el|
    if el == 'X'
      true
    elsif el == 'O'
      true
    end
  end
  element
end

def draw(board)
  if board_full(board)
    win(board).class != Array
  else
    false
  end
end

def move(board, index, token = 'X')
  board[index] = token
end

def available_slots(board)
  slots = []
  board.each do |x|
    slots << x if x.is_a? Integer
  end
  if slots.count.even?
    puts 'Player 2\'s turn'
  else
    puts 'Player 1\'s turn'
  end
  slots.each { |x| print x.to_s + ' ' }
end

def turn(board)
  is_valid_move = false
  until is_valid_move == true
    available_slots(board)
    puts ''
    puts 'Make a move. Select one the above slots.'
    puts ''
    input = gets.chomp
    input = convert_input(input)
    is_valid_move = valid_move(board, input)
    puts ''
    puts '-----------------------------------------'
    puts ''
  end

  move(board, input, current_player(board))
  display_board(board)
  puts ''
end

def current_player(board)
  count_move(board).even? ? 'X' : 'O'
end

def count_move(board)
  counter = 0
  board.each do |b|
    if b == 'X'
      counter += 1
    elsif b == 'O'
      counter += 1
    end
  end
  counter
end

play(board, player_one, player_two)
