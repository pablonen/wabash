class BuildsController < ApplicationController
  before_action :set_game
  before_action :authenticate_user!

  # GET /games/1/new_build
  def new_build
    render 'games/new_build'
  end

  # POST /games/1/builds
  def build
    # validate user turn
    b = Build.new current_user, @game, params[:hex]
    # validate legit turn
    # persist turn to state
    respond_to do |format|
      if b.valid?
        @game.build(params[:hex])
        @game.next_turn!
        format.html { redirect_to game_url(@game), notice: "built!"}
      else
        format.html { render 'games/new_build', status: :unprocessable_entity }
      end
    end
  end

  private
    def set_game
      @game = Game.find(params[:game_id])
    end

    def build_params
      params.require(:build).permit(:hex, :game_id)
    end
end
