require 'spec_helper'

describe Player do
  
  it 'should initialize' do
    player = Player.new 'Dave'
    player.name.should == 'Dave'
    player.deck.should be_a(Deck)
  end
  
  it 'should gain' do
    player = Player.new 'Player'
    copper = Copper.new
    player.gain copper
    player.discard.should == [copper]
  end
  
end