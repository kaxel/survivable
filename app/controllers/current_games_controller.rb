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
  
  def add_next
    @current_game = CurrentGame.where(user_id: current_user.id).first
    e = Event.find(params[:event_id])
    d = @current_game.latest_day
    num = @current_game.latest_day.hour + 1
    nexttask = DayTask.new
    nexttask.event_id = e.id
    nexttask.day_id = d.id
    nexttask.num = num
    if nexttask.save
      message = e.process(@current_game)
      nexttask.update_message(message)
      @current_game.hunger_down
      Event.insert_possession_related_events(@current_game)
      Event.add_events_for_requirements_met(@current_game)
      redirect_to gameplay_path, notice: message
    end
  end
  
  def add_subsequent_day
    @current_game = CurrentGame.where(user_id: current_user.id).first
    last_day_num = @current_game.latest_day.num
    @newday = Day.new
    @newday.current_game_id = @current_game.id
    @newday.num = last_day_num+1
    @newday.save
    @current_game.days<<@newday
    
    message="Good morning!"
    redirect_to gameplay_path, notice: message
  end

  # GET /current_games/1 or /current_games/1.json
  def show
    set_current_game
  end

  # GET /current_games/new
  def new
    @current_game = CurrentGame.where(user_id: current_user.id).first
    if @current_game
      redirect_to gameplay_path, notice: "You are already playing a game."
    else
      @current_game = CurrentGame.new
    end
  end

  # GET /current_games/1/edit
  def edit
    set_current_game
  end

  # POST /current_games or /current_games.json
  def create
    @survivalist = Survivalist.find(params[:survivalist_id])
    @current_game = CurrentGame.new
    @current_game.user_id = current_user.id
    @current_game.survivalist_id = params[:survivalist_id]
    @current_game.location_id = params[:location_id]
    #set starting scores
    @current_game.mood = @survivalist.starting_mood_score
    @current_game.hunger = @survivalist.starting_hunger_score
    @current_game.maxdays = params[:max_day_value]
    
    @collection = Collection.find(params[:collection_id])
    
    respond_to do |format|
      if @current_game.save
        #add new events
        Event.insert_starting_events(@current_game)
        Event.insert_possession_related_events(@current_game)
        
        #make first day
        puts "set new day"
        @newday = Day.new
        @newday.current_game_id = @current_game.id
        @newday.num = 1
        @newday.morning_message = "You begin your journey next to a reliable water supply."
        @newday.save
        @current_game.days<<@newday
        #add starting items
        @collection.projects.each {|p| @current_game.possessions << Possession.input_new_possession(@current_game, p)}
        
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
      params.require(:current_game).permit(:sig, :ip, :survivalist_id, :user_id, :location_id, :max_day_value)
    end
end
