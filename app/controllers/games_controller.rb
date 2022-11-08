class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy build new_build join new_join destroy_join]
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

  # POST /games/1/join
  def join
    @user = User.find(params[:user_id])
    respond_to do |format|
      unless @user.in_game?(@game)
        @user.game_players.create(game: @game, seat: @game.players.size)
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
      GamePlayer.find_by(game_id: @game.id, user_id: current_user.id ).destroy
      format.html { redirect_to game_url(@game), notice: "Left game" }
    end
  end

  # POST /games/1/build
  def build
    # validate user turn
    # validate legit turn
    # persist turn to state
    respond_to do |format|
      format.html { redirect_to game_url(@game), notice: "built!"}
    end
  end

  # GET /games/1/new_build
  def new_build
  end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params)

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
      params.require(:game).permit(:name, :min_players, :max_players, :state)
    end
end
