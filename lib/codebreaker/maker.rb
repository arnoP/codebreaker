module Codebreaker
  class Maker
    attr_reader :secret_code
    SECRET_CODE_SIZE = 4

    def initialize
      @secret_code = ""
    end

    def make
      SECRET_CODE_SIZE.times { @secret_code << "#{rand(1..6)}"}
      @secret_code
    end 
  end
end