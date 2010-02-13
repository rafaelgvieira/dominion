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
  
  it 'should draw an opening hand' do
    game = GameFactory.build
    game.players.first.hand.size.should == 5
  end
  
  it 'should determine available actions' do
    player = Player.new 'John'
    player.should have(0).available_actions
    player.hand << Village.new
    player.hand << Smithy.new
    player.hand << Copper.new
    player.hand << Gardens.new
    player.hand << Estate.new
    player.should have(2).available_actions
  end
  
  it 'should discard deck' do
    game = GameFactory.build
    player = game.players.first
    player.deck.size.should == 5
    player.discard.size.should == 0
    player.discard_deck
    player.deck.size.should == 0
    player.discard.size.should == 5
  end
  
  it 'should draw a card with one in the deck' do
    player = Player.new 'Draw'
    copper = Copper.new
    player.deck << copper
    player.draw.should == [copper]
    player.hand.should == [copper]
    player.deck.should be_empty
  end
  
  it 'should not draw if none available' do
    player = Player.new 'Draw'
    player.draw.should == []
    player.hand.should be_empty
    player.deck.should be_empty
  end
  
  it 'should reshuffle if needed on draw' do
    player = Player.new 'Draw'
    copper = Copper.new
    player.discard << copper
    player.draw.should == [copper]
    player.hand.should == [copper]
    player.deck.should be_empty
    player.discard.should be_empty
  end
end