require 'spec_helper'

describe Feast do
  
  it 'should execute' do
    game = GameFactory.build
    player = game.next_player
    turn = Turn.new game, player
    duchy = game.duchies.first
    feast = Feast.new
    feast.stub!(:select_card).and_return(duchy)
    
    turn.execute feast
    game.trash.should == [feast]
    player.discard.should == [duchy]
  end
  
end