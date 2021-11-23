class ClimatesController < ApplicationController
  before_action :set_climate, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  
  def load_default
    message = Climate.load_default
    redirect_to my_admin_path, notice: "Successful: #{message}"
  end
  
  def destroy_default
    message = Climate.destroy_default
    redirect_to my_admin_path, notice: "Successful: #{message}"
  end

  # GET /climates or /climates.json
  def index
    @climates = Climate.all
  end

  # GET /climates/1 or /climates/1.json
  def show
  end

  # GET /climates/new
  def new
    @climate = Climate.new
  end

  # GET /climates/1/edit
  def edit
  end

  # POST /climates or /climates.json
  def create
    @climate = Climate.new(climate_params)

    respond_to do |format|
      if @climate.save
        format.html { redirect_to @climate, notice: "Climate was successfully created." }
        format.json { render :show, status: :created, location: @climate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @climate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /climates/1 or /climates/1.json
  def update
    respond_to do |format|
      if @climate.update(climate_params)
        format.html { redirect_to @climate, notice: "Climate was successfully updated." }
        format.json { render :show, status: :ok, location: @climate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @climate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /climates/1 or /climates/1.json
  def destroy
    @climate.destroy
    respond_to do |format|
      format.html { redirect_to climates_url, notice: "Climate was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_climate
      @climate = Climate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def climate_params
      params.require(:climate).permit(:name, :cold_warm, :cold_floor, :warm_ceiling, :intensity, :trend)
    end
end
