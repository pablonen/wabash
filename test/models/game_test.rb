require "test_helper"

class GameTest < ActiveSupport::TestCase
  setup do
    @game = games(:one)
    @user1 = users(:one)
    @user2 = users(:two)
    @game.start!
    @auction = Auction.new(@user1, @game, 'red', 3)
  end

  test 'start_auction!' do
    @game.start_auction! @auction
    #assert @game.bidders == [@user1.id,@user2.id], 'bidders is wrong'
    assert @game.bidding_seat == 1
  end

  test 'auction passing' do
    assert @game.user_acting?(@user1), "user1 is not acting on game start"
    @game.start_auction! @auction
    assert @game.user_acting?(@user2)
    @game.pass_auction(@user2, @auction) 
    assert @game.user_acting?(@user2), "user2 should be acting after user1 passes and gets the company"
    assert @game.phase?(:choose_action), "the auction is over and the user2 is up to choose an action"
  end

  test 'next_bidder!' do
    @game.start_auction! @auction
    assert @game.user_acting?(@user2)
    @game.next_bidder!(@user2)
    assert @game.user_acting?(@user1)
  end

  test 'auction bidding' do
    @game.start_auction! @auction
    auction_bid1 = Auction.new(@user2, @game, 'red', 4)
    @game.bid_auction!(@user2, auction_bid1)
    assert @game.user_acting?(@user1), "user1 should be bidding for more or passing"
    assert @game.phase?(:bidding)
    assert @game.high_bid == 4
    assert @game.high_bidder == @user2.seat_in(@game)

    auction_bid2 = Auction.new(@user1, @game, 'red', 5)
    @game.bid_auction!(@user1, auction_bid2)
    assert @game.user_acting?(@user2)
    assert @game.phase?(:bidding)
    assert @game.high_bid == 5
    assert @game.high_bidder == @user1.seat_in(@game)

    auction_pass = Auction.new(@user2, @game, 'red', -1)
    @game.pass_auction(@user2, auction_pass)
    assert @game.state['passers'] = [@user2.id]
    assert @game.phase?(:choose_action)
    assert @game.user_acting?(@user2)

    assert @user1.money(@game) == 60-5
    assert @user1.shares(@game) == ['red']
  end
end
