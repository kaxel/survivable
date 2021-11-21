class PossessionsController < ApplicationController
  before_action :set_possession, only: %i[ show edit update destroy ]

  # GET /possessions or /possessions.json
  def index
    @possessions = Possession.all
  end

  # GET /possessions/1 or /possessions/1.json
  def show
  end

  # GET /possessions/new
  def new
    @possession = Possession.new
  end

  # GET /possessions/1/edit
  def edit
  end

  # POST /possessions or /possessions.json
  def create
    @possession = Possession.new(possession_params)

    respond_to do |format|
      if @possession.save
        format.html { redirect_to @possession, notice: "Possession was successfully created." }
        format.json { render :show, status: :created, location: @possession }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @possession.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /possessions/1 or /possessions/1.json
  def update
    respond_to do |format|
      if @possession.update(possession_params)
        format.html { redirect_to @possession, notice: "Possession was successfully updated." }
        format.json { render :show, status: :ok, location: @possession }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @possession.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /possessions/1 or /possessions/1.json
  def destroy
    @possession.destroy
    respond_to do |format|
      format.html { redirect_to possessions_url, notice: "Possession was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_possession
      @possession = Possession.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def possession_params
      params.require(:possession).permit(:name, :bonus, :current_game_id)
    end
end
