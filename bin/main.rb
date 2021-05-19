#!/usr/bin/env ruby
require_relative '../lib/draw_logic'
require_relative '../lib/game_logic'
cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
# rubocop:disable Metrics/MethodLength

def players_info
  puts 'Welcome to Ruby\'s Tic Tac Toe!'
  begin
    puts 'Enter Player 1 name: '
    player1 = gets.chomp.capitalize
    puts ''
    raise StandardError, player1 if player1.empty?
  rescue StandardError
    puts 'Oh no!, This can\'t be blank.'
    puts ''
    retry
  end

  begin
    puts 'Enter Player 2 name: '
    player2 = gets.chomp.capitalize
    puts ''
    raise StandardError, player2 if player2.empty?
  rescue StandardError
    puts 'Oh no!, This can\'t be blank.'
    puts ''
    retry
  end

  puts "#{player1} is X and #{player2} is O."
  sleep 2
  puts ''
  puts 'It\'s game time!'
  puts ''
  sleep 2
  system 'cls'
  system 'clear'
  [player1, player2]
end

players = players_info

board = proc do
  puts '+---+---+---+'
  puts "| #{cells[0]} | #{cells[1]} | #{cells[2]} |"
  puts '+---+---+---+'
  puts "| #{cells[3]} | #{cells[4]} | #{cells[5]} |"
  puts '+---+---+---+'
  puts "| #{cells[6]} | #{cells[7]} | #{cells[8]} |"
  puts '+---+---+---+'
end

def start(player, board, arg, records)
  board.call
  puts ''
  puts "It's #{player}'s turn!"
  puts ''
  begin
    puts 'Please select an available cell from the board: '
    input = gets.chomp
    puts ''
    if input.nil? || !(input.to_i >= 1 && input.to_i < 10) || !records[input.to_i - 1].is_a?(Integer)
      raise StandardError,
            input
    end
  rescue StandardError
    puts 'Invalid move. Please enter a number from 1-9.'
    puts ''
    retry
  end
  records[input.to_i - 1] = arg
  system 'cls'
  system 'clear'
  sleep 1
end

def game_play(players, board, cells)
  game_on = true

  while game_on
    start(players[0], board, 'X', cells)
    logic = Logic.new(cells)
    draw = Draw.new(cells)

    if logic.winner?('X')
      board.call
      puts ''
      puts "#{players[0]} wins the game!"
      sleep 2
      game_on = false
      return
    elsif draw.draw?
      board.call
      puts ''
      puts 'It\'s a Tie!'
      puts ''
      puts 'Game Over'
      sleep 2
      game_on = false
      return
    end

    start(players[1], board, 'O', cells)
    logic = Logic.new(cells)
    draw = Draw.new(cells)

    if logic.winner?('O')
      board.call
      puts ''
      puts "#{players[1]} wins the game!"
      sleep 2
      game_on = false
      return
    elsif draw.draw?
      board.call
      puts ''
      puts 'It\'s a Tie!'
      puts ''
      puts 'Game Over'
      sleep 2
      game_on = false
      return
    end
  end
end

game_play(players, board, cells)
# rubocop:enable Metrics/MethodLength
