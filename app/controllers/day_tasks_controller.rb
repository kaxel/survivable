class DayTasksController < ApplicationController
  before_action :set_day_task, only: %i[ show edit update destroy ]

  # GET /day_tasks or /day_tasks.json
  def index
    @day_tasks = DayTask.all
  end

  # GET /day_tasks/1 or /day_tasks/1.json
  def show
  end

  # GET /day_tasks/new
  def new
    @day_task = DayTask.new
  end

  # GET /day_tasks/1/edit
  def edit
  end

  # POST /day_tasks or /day_tasks.json
  def create
    @day_task = DayTask.new(day_task_params)

    respond_to do |format|
      if @day_task.save
        format.html { redirect_to @day_task, notice: "Day task was successfully created." }
        format.json { render :show, status: :created, location: @day_task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @day_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /day_tasks/1 or /day_tasks/1.json
  def update
    respond_to do |format|
      if @day_task.update(day_task_params)
        format.html { redirect_to @day_task, notice: "Day task was successfully updated." }
        format.json { render :show, status: :ok, location: @day_task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @day_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /day_tasks/1 or /day_tasks/1.json
  def destroy
    @day_task.destroy
    respond_to do |format|
      format.html { redirect_to day_tasks_url, notice: "Day task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_day_task
      @day_task = DayTask.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def day_task_params
      params.require(:day_task).permit(:num, :day_id, :event_id, :message)
    end
end
