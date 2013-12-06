require 'codebreaker/game'
require 'codebreaker/view'

while true do
  view = Codebreaker::View.new
  view.welcome
  while true do
    i = view.enter
    c = view.result if i.is_a? String
    break if c == "y"
  end
end