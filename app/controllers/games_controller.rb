class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy start join new_join destroy_join]
  before_action :authenticate_user!

  # GET /games or /games.json
  def index
    @games = Game.all
  end

  # GET /games/1 or /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new state: nil
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games/1/start
  def start
    respond_to do |format|
      # TODO, extract_method
      if current_user == @game.owner
        @game.start!
        @game.broadcast_updates
        format.html { redirect_to game_url(@game), notice: 'Game started!' }
      else
        format.html { redirect_to game_url(@game), notice: 'You must be the game ownre to start a game' }
      end
    end
  end

  # POST /games/1/join
  def join
    @user = User.find(params[:user_id])
    respond_to do |format|
      unless @user.in_game?(@game)
        @user.join_in(@game)
        @game.broadcast_updates
        format.html { redirect_to game_url(@game), notice: "you joined the game!" }
      else
        format.html { redirect_to game_url(@game), notice: "already joined in game!" }
      end
    end
  end

  # GET /games/1/new_join
  def new_join
  end

  # DELETE /games/1/joins/1
  def destroy_join
    respond_to do |format|
      unless @game.started?
        GamePlayer.find_by(game_id: @game.id, user_id: current_user.id ).destroy
        @game.broadcast_updates
        format.html { redirect_to game_url(@game), notice: "Left game" }
      else
        format.html { redirect_to game_url(@game), notice: "Game started, cannot leave the game!" }
      end
    end
  end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @game.save
        format.html { redirect_to game_url(@game), notice: "Game was successfully created." }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        @game.broadcast_updates
        format.html { redirect_to game_url(@game), notice: "Game was successfully updated." }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:name, :min_players, :max_players, :state, :user_id)
    end
end
