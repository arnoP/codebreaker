require 'spec_helper'
 
module Codebreaker
  describe Game do
    let(:game) do
      maker = double("maker")
      maker.stub(:make).and_return("1352") 
      Game.new(maker.make) 
    end

    it "have secret code" do
      expect(game.send(:secret_code)).to eq("1352")
    end
    it "receive a user code" do
      game.user_code = "1263"
      expect(game.user_code).to eq("1263")
    end
    it "give a hint" do
      expect(game.hint).to match(/^[1352]$/)
    end
    
    context "#compare" do
      # regexp /^[+-]{1,4}$/
      let(:compared) { game.compare }
      it "full fail" do
        game.user_code = "4664"
        expect(compared).to eq([])
      end
      #how to describe all specs below???
      it "one equal but with different places" do
        game.user_code = "4634"
        expect(compared).to eq(["-"])
      end
      it "full equal(equal value and equal place)" do
        game.user_code = "4366"
        expect(compared).to eq(["+"])
      end
      it "one equal but with different places" do
        game.user_code = "1436"
        expect(compared).to eq(["+", "-"])
      end
      it "full equal(equal value and equal place)" do
        game.user_code = "1325"
        expect(compared).to eq(["+", "+", "-", "-"])
      end
    end
  end
end