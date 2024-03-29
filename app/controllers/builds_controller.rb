class BuildsController < ApplicationController
  before_action :set_game
  before_action :authenticate_user!

  # GET /games/1/new_build
  def new_build
    render 'games/new_build'
  end

  # POST /games/1/builds
  def build
    b = Build.new current_user, params[:company], @game, params[:hex]
    respond_to do |format|
      if b.valid?
        @game.build(b)
        @game.broadcast_updates
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
