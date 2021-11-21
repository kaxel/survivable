class SurvivalistsController < ApplicationController
  before_action :authenticate_user!
  
  def get_default
    Survivalist.add_default
    redirect_to new_current_game_path
  end

  # GET /survivalists or /survivalists.json
  def index
    @survivalists = Survivalist.all
  end

  # GET /survivalists/1 or /survivalists/1.json
  def show
  end

  # GET /survivalists/new
  def new
    @survivalist = Survivalist.new
  end

  # GET /survivalists/1/edit
  def edit
  end

  # POST /survivalists or /survivalists.json
  def create
    @survivalist = Survivalist.new(survivalist_params)

    respond_to do |format|
      if @survivalist.save
        format.html { redirect_to @survivalist, notice: "Survivalist was successfully created." }
        format.json { render :show, status: :created, location: @survivalist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @survivalist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /survivalists/1 or /survivalists/1.json
  def update
    respond_to do |format|
      if @survivalist.update(survivalist_params)
        format.html { redirect_to @survivalist, notice: "Survivalist was successfully updated." }
        format.json { render :show, status: :ok, location: @survivalist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @survivalist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /survivalists/1 or /survivalists/1.json
  def destroy
    @survivalist.destroy
    respond_to do |format|
      format.html { redirect_to survivalists_url, notice: "Survivalist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survivalist
      @survivalist = Survivalist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def survivalist_params
      params.require(:survivalist).permit(:strength, :creativity, :determination, :optimism, :skill)
    end
end
