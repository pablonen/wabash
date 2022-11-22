class PassesController < ApplicationController
  before_action :set_game
  before_action :authenticate_user!

  def pass_action
    pa = PassAction.new( @game, current_user, params[:action_type] )
    respond_to do |format|
      if pa.valid?
        @game.pass_action(pa)
        format.html { redirect_to game_url(@game), notice: "passed" }
      else
        format.html { render 'games/show', status: :unprocessable_entity, notice: "error in passing" }
      end
    end
  end

  private
    def set_game
      @game = Game.find(params[:game_id])
    end

    def build_params
      params.require(:action_type)
    end
end
