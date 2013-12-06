require 'spec_helper'
 
module Codebreaker
  describe Maker do
    context "secret code" do
      let(:maker) { Maker.new }
      let(:code) { maker.secret_code }

      it "empty if method #make not called" do #how to describe it???
        expect(code).to be_empty
      end
      context "#make" do
        let!(:made) { maker.make } #right or wrong???
        it "not empty" do
          expect(code).to_not be_empty
        end
        it "have 4 numbers" do
          expect(code.size).to eq(4)
        end
        it "is a valid code" do
          expect(code).to match(/^[1-6]{4}$/)
        end
      end
    end
  end
end