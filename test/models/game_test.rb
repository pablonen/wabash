require "test_helper"

class GameTest < ActiveSupport::TestCase
  setup do
    @game = games(:one)
    @game2 = games(:two)
    @user1 = users(:one)
    @user2 = users(:two)
    @user3 = users(:three)
    @game.start!
    @game2.start!
    @auction = Auction.new(@user1, @game, 'red', 3)
  end

  test 'start_auction!' do
    @game.start_auction! @auction
    #assert @game.bidders == [@user1.id,@user2.id], 'bidders is wrong'
    assert @game.bidding_seat == 1
    assert @game.state['auctions'] == 1
  end

  test 'auction passing' do
    assert @game.user_acting?(@user1), "user1 is not acting on game start"
    @game.start_auction! @auction
    assert @game.user_acting?(@user2)
    @game.pass_auction!(@user2, @auction)
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
    @game.pass_auction!(@user2, auction_pass)
    assert @game.state['passers'] = [@user2.id]
    assert @game.phase?(:choose_action)
    assert @game.user_acting?(@user2)

    assert @user1.money(@game) == 60-5
    assert @user1.shares(@game) == ['red']

    assert @game.state['companies']['red']['money'] == 5
  end

  test 'multiplayer passing' do
    assert @game2.user_acting?(@user1)
    start_auction = Auction.new(@user1, @game2, 'red', 4, starting_bid: true)
    @game2.start_auction! start_auction
    assert @game2.user_acting?(@user2)
    pass_auction = Auction.new(@user2, @game2, 'red', -1, pass: true)
    @game2.pass_auction! @user2, pass_auction
    assert @game2.user_acting?(@user3)

    bid_auction1 = Auction.new(@user3, @game2, 'red', 5)
    @game2.bid_auction! @user3, bid_auction1
    assert @game2.user_acting? @user1

    bid_auction2 = Auction.new(@user1, @game2, 'red', 6)
    @game2.bid_auction! @user1, bid_auction2

    assert @game2.user_acting?(@user3), "user2 has passed and should not be bidding now"
    assert !(@game2.user_acting?(@user2)), "user2 has passed and should not be bidding now"
  end

  test 'round_end?' do
    @game.state['builds'] = 4
    @game.state['auctions'] = 3
    @game.state['developments'] = 4
    assert @game.round_end?

    @game.state['builds'] = 5
    @game.state['auctions'] = 3
    @game.state['developments'] = 0
    assert @game.round_end?

    @game.state['builds'] = 5
    @game.state['auctions'] = 0
    @game.state['developments'] = 4
    assert @game.round_end?

    @game.state['builds'] = 5
    @game.state['auctions'] = 0
    @game.state['developments'] = 1
    assert !@game.round_end?

    @game.state['builds'] = 5
    @game.state['auctions'] = 2
    @game.state['developments'] = 0
    assert !@game.round_end?

    @game.state['builds'] = 3
    @game.state['auctions'] = 0
    @game.state['developments'] = 4
    assert !@game.round_end?
  end

  test 'dividend_phase!' do
    @game.state['players']['0']['money'] = 0
    @game.state['players']['1']['money'] = 0

    @game.state['players']['0']['shares'] = ['red', 'blue', 'red']
    @game.state['players']['1']['shares'] = ['yellow','green','blue', 'red']

    @game.state['companies']['red']['sold_shares'] = 3
    @game.state['companies']['blue']['sold_shares'] = 2
    @game.state['companies']['yellow']['sold_shares'] = 1
    @game.state['companies']['green']['sold_shares'] = 1

    @game.state['companies']['red']['income'] = 12
    @game.state['companies']['yellow']['income'] = 9
    @game.state['companies']['green']['income'] = 10

    @game.state['builds'] = 4
    @game.state['auctions'] = 3
    @game.state['developments'] = 4

    @game.next_turn!

    assert @game.state['players']['0']['money'] == 4+4+3 , "p0 money is off"
    assert @game.state['players']['1']['money'] == 4+3+10+9, "p1 money should be 29, but was #{@game.state['players']['1']['money']}"

    assert @game.state['builds'].zero?
    assert @game.state['auctions'].zero?
    assert @game.state['developments'].zero?

    assert @game.state['hexes'][Game::DETROIT]['income'] == 2
  end

  test 'build' do
    b = Build.new @user1, 'red', @game, ['R3']
    @game.build(b)
    @game.reload
    assert @game.state['builds'] == 1
  end
end
