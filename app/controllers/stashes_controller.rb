class StashesController < ApplicationController
  before_action :set_stash, only: %i[ show edit update destroy ]

  # GET /stashes or /stashes.json
  def index
    @stashes = Stash.all
  end

  # GET /stashes/1 or /stashes/1.json
  def show
  end

  # GET /stashes/new
  def new
    @stash = Stash.new
  end

  # GET /stashes/1/edit
  def edit
  end

  # POST /stashes or /stashes.json
  def create
    @stash = Stash.new(stash_params)

    respond_to do |format|
      if @stash.save
        format.html { redirect_to @stash, notice: "Stash was successfully created." }
        format.json { render :show, status: :created, location: @stash }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stashes/1 or /stashes/1.json
  def update
    respond_to do |format|
      if @stash.update(stash_params)
        format.html { redirect_to @stash, notice: "Stash was successfully updated." }
        format.json { render :show, status: :ok, location: @stash }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stashes/1 or /stashes/1.json
  def destroy
    @stash.destroy
    respond_to do |format|
      format.html { redirect_to stashes_url, notice: "Stash was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stash
      @stash = Stash.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stash_params
      params.require(:stash).permit(:name, :current_game_id, :resource_id, :quantity)
    end
end
