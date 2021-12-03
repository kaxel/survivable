class CurrentGamesController < ApplicationController
  before_action :authenticate_user!

  # GET /current_games or /current_games.json
  def index
    @current_games = CurrentGame.all
  end
  
  def gameplay
    @current_game = CurrentGame.where(user_id: current_user.id).first
    render :template => "cards/gameplay"
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
    @current_game = CurrentGame.new
    @current_game.user_id = current_user.id
    @current_game.survivalist_id = params[:survivalist_id]
    @current_game.location_id = params[:location_id]
    
    @collection = Collection.find(params[:collection_id])
    
    respond_to do |format|
      if @current_game.save
        #add new events
        Event.insert_starting_events(@current_game)
        
        #make first day
        puts "set new day"
        @newday = Day.new
        @newday.current_game_id = @current_game.id
        @newday.num = 1
        @newday.save
        puts "save the day !!!"
        @current_game.days<<@newday
        puts "day added to collection"
        puts @newday.inspect
        #add starting items
        @collection.projects.each {|p| @current_game.possessions << Possession.input_starter_possession(@current_game, p)}
        
        format.html { redirect_to gameplay_path, notice: "Current game was successfully created." }
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
      params.require(:current_game).permit(:sig, :ip, :survivalist_id, :user_id, :location_id)
    end
end
