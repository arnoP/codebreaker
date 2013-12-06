require 'codebreaker/guess'

module Codebreaker
  class Game
    CODE_SIZE = 4
    attr_writer :secret_code
    attr_accessor :user_code
    attr_reader :result, :number_of_turns, :turns_done

    def initialize(secret_code)
      @secret_code = secret_code
      @number_of_turns = 0
      @turns_done = 0
      @user_code = ""
      @result = []
    end

    def number_of_turns=(number)
      number = number.to_i
      @number_of_turns = case number
      when 3 then 7
      when 2 then 10
      when 1 then 15
      else
        nil 
      end
    end

    def user_code=(user_code)
      guess = Codebreaker::Guess.new(user_code)
      @user_code = user_code if guess.valid?
    end

    def turns?
      if @turns_done < @number_of_turns
        @turns_done += 1
        true
      else
        false
      end
    end

    def compare
      @result = []
      codes = make_arrays_for_codes
      secret_code, user_code = codes[:secret_code], codes[:user_code]
      CODE_SIZE.size.times do |i = 0|
        if secret_code.include? user_code[i]
          if secret_code[i] == user_code[i]
            secret_code[i] = -1
            @result.insert(0, "+")
          else
            secret_code[secret_code.index(user_code[i])] = -1
            @result << "-"
          end
        end 
        i += 1
      end
      @result
    end

    def hint
      @secret_code[rand(0..3)]
    end

    private
    def make_arrays_for_codes
      secret_code, user_code = [], []
      CODE_SIZE.times do |i = 0|
        secret_code << @secret_code[i].to_i
        user_code << @user_code[i].to_i
        i += 1 
      end
      {secret_code: secret_code, user_code: user_code}
    end

    private #for specs
    def secret_code
      @secret_code
    end
  end
end