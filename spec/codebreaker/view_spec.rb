require 'spec_helper'
 
module Codebreaker
  describe View do
    context "view a" do
      let(:view) { View.new }
      let(:welcome_array) {[
        "\n\tWelcome to Codebreaker!!!",
        "\t'hint' - you will get a hint",
        "\t'quit' - end of the game",
        "\tEnter 4 number each from 1 to 6 and press 'enter'\n\n",
        "\tSet the level of complexity: easy - 1, average - 2, hard - 3\n\n"
        ]}

      it "#welcome" do
        welcome_array.each do |item|
          view.should_receive(:puts).with(item)
        end
        view.stub(:gets).and_return(3)
        view.welcome
      end
      it "#enter" do
        view.stub(:gets).and_return("2651")
        view.should_receive(:puts).with("Enter numbers:")
        view.enter
      end
      it "#result" do
        #Codebreaker::Game.stub(:new).and_return(true)
        view.stub(:play_again?).and_return(false)
        view.should_receive(:puts).with("You lose...")
        view.should_receive(:puts).with(/Secret code: [1-6]{4}$/)
        view.result
      end
      it "#finish result" do
        view.should_receive(:puts).with("You needed 0 turns")
        view.send(:finish_result)
      end
      it "#hint" do
        view.should_receive(:puts).with(/Hint: [1-6]$/)
        view.send(:hint)
      end
      it "#save_game" do
        view.stub(:gets).and_return("")
        view.should_receive(:puts).with("Enter you name:")
        view.should_receive(:puts).with("Game saved")
        view.send(:save_game)
      end
      it "#play again" do
        view.should_receive(:puts).with("Play again?[y/n]:")
        view.stub(:gets).and_return("y\n")
        view.send(:play_again?)
      end
    end
  end
end