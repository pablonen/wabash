class DevelopmentsController < ApplicationController
  before_action :set_game
  before_action :authenticate_user!

  def new_development
    render 'new_development'
  end

  def develop
    d = Development.new current_user, @game, params[:hex]
    respond_to do |format|
      if d.valid?
        @game.develop(d)
        @game.broadcast_updates
        format.html { redirect_to game_url(@game), notice: "developped!"}
      else
        format.html { render 'new_development', status: :unprocessable_entity }
      end
    end
  end

  private
    def set_game
      @game = Game.find(params[:game_id])
    end

    def development_params
      params.require(:development).permit(:hex, :game_id)
    end

end
