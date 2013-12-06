require 'spec_helper'
 
module Codebreaker
  describe Guess do
    context "#valid?" do
      let(:valid_guess) do Guess.new("2231") end
      let(:not_valid_guess) { Guess.new("32454") }
      let(:not_valid_guess_too) { Guess.new("7219") }

      it "when data is valid" do
        expect(valid_guess).to be_valid
      end
      it "if data is not valid" do #how to describe it???
        expect(not_valid_guess).to_not be_valid
      end
      it "if data is not valid" do #how to describe it???
        expect(not_valid_guess_too).to_not be_valid
      end
    end 
  end
end