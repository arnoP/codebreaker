require 'codebreaker/maker'

module Codebreaker
  class View
    attr_writer :number_of_turns, :secret_code
    attr_accessor :turns_done

    def initialize
      @give_hint = true
      @turns_done = 0
      @number_of_turns = 0
      @maker = Codebreaker::Maker.new
      @secret_code = @maker.make
      @guess = Codebreaker::Guess.new
      @game = Codebreaker::Game.new(@secret_code)
    end

    def welcome
      puts "\n\tWelcome to Codebreaker!!!"
      puts "\t'hint' - you will get a hint"
      puts "\t'quit' - end of the game"
      puts "\tEnter 4 number each from 1 to 6 and press 'enter'\n\n"
      puts "\tSet the level of complexity: easy - 1, average - 2, hard - 3\n\n"
      @game.number_of_turns = gets
      welcome unless @game.number_of_turns
    end
    
    def enter
      puts "Enter numbers:"
      user_code = gets
      if user_code == "hint\n"
        hint
      elsif user_code == "quit\n"
        exit
      else
        @guess.code = user_code
        if @guess.valid?
          @game.user_code = user_code
        else
          puts "\n\tShoud be 4 numbers each from 1 to 6!!! Try again!!!\n\n"
          enter
        end 
      end
    end

    def result
      if @game.turns?
        result = @game.compare
        if result == ["+", "+", "+", "+"]
          puts "You WIN!!!"
          finish_result
          save_game
          return play_again?
        else
          puts "Result: #{result}" unless result == []
        end
      else
        puts "You lose..."
        puts "Secret code: #{@secret_code}"
        return play_again?
      end
    end

    private
    def hint
      if @give_hint
        puts "Hint: #{@game.hint}"
        @give_hint = false
      else
        puts "No more hint..."
      end
    end

    private
    def play_again?
      puts "Play again?[y/n]:"
      res = gets
      if res == "y\n"
        "y"
      elsif res == "n\n"
        exit
      else
        puts "Error data!!!"
      end
    end

    private
    def save_game
      puts "Enter you name:"
      name = gets
      f = File.open("./data.txt", "w+") if File.exists?("./data.txt")
      f.write "Time: #{Time.now}\nName: #{name}Turns: #{@turns_done}\n"
      f.close
      puts "Game saved"
    end

    private
    def finish_result
      puts "You needed #{@game.turns_done} turns"
    end

  end
end