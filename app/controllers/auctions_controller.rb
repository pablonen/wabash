class AuctionsController < ApplicationController
  before_action :set_game
  before_action :authenticate_user!

  def new_auction
  end

  def start
    auction = Auction.new(current_user, @game, params[:company], params[:bid])
    respond_to do |format|
      if auction.valid?
        @game.start_auction!(auction)
        format.html { redirect_to game_url(@game), notice: 'Auction started' }
      else
        format.html { render 'new_auction', status: :unprocessable_entity } 
      end
    end
  end

  def new_bid
  end

  def bid
    auction_action = Auction.new(current_user, @game, params[:company], params[:bid])
    respond_to do |format|
      if auction_action.valid?
        @game.bid_auction!(current_user, auction_action)
        format.html { redirect_to game_url(@game), notice: 'Bade' }
      else
        format.html { render 'new_bid', status: :unprocessable_entity }
      end
    end
  end

  def pass
    auction_action = Auction.new(current_user, @game, params[:company], -1 )
    respond_to do |format|
      if auction_action.valid?
        @game.pass_auction(current_user, auction_action)
        format.html { redirect_to game_url(@game), notice: 'Passed' }
      else
        format.html { redirect_to 'new_bid', status: :unprocessable_entity }
      end
    end
  end

  private
    def set_game
      @game = Game.find(params[:game_id])
    end

    # TODO, require bid, and company?
    def auction_params
      params.require(:auction).permit(:bid, :company, :pass, :game_id)
    end
end
