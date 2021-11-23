class CurrentGamesController < ApplicationController
  before_action :authenticate_user!

  # GET /current_games or /current_games.json
  def index
    @current_games = CurrentGame.all
  end
  
  def delete_game
    @current_game = CurrentGame.where(user_id: current_user.id).first
    if @current_game
      message = CurrentGame.delete_game(@current_game.id)
    else
      message = "No current game is present."
    end
    redirect_to my_admin_path, notice: message
  end

  # GET /current_games/1 or /current_games/1.json
  def show
    set_current_game
  end

  # GET /current_games/new
  def new
    @current_game = CurrentGame.new
  end

  # GET /current_games/1/edit
  def edit
    set_current_game
  end

  # POST /current_games or /current_games.json
  def create
    @current_game = CurrentGame.new(current_game_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @current_game.save
        #add new events
        Event.insert_starting_events(@current_game)
        
        format.html { redirect_to @current_game, notice: "Current game was successfully created." }
        format.json { render :show, status: :created, location: @current_game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @current_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /current_games/1 or /current_games/1.json
  def update
    respond_to do |format|
      if @current_game.update(current_game_params)
        format.html { redirect_to @current_game, notice: "Current game was successfully updated." }
        format.json { render :show, status: :ok, location: @current_game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @current_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /current_games/1 or /current_games/1.json
  def destroy
    Event.delete_related(@current_game.id)
    @current_game.destroy
    
    respond_to do |format|
      format.html { redirect_to current_games_url, notice: "Current game was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_game
      @current_game = CurrentGame.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def current_game_params
      params.require(:current_game).permit(:sig, :ip, :survivalist_id, :user_id)
    end
end
