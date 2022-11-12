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

  def bid
  end

  def pass
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
