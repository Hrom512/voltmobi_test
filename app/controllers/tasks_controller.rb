class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_task, only: [:show, :edit, :update, :destroy, :start, :finish]
  before_action :check_access, only: [:edit, :update, :destroy, :start, :finish]

  def index
    @tasks = default_scope
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user

    if @task.save
      redirect_to profile_path
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to profile_path
  end

  def start
    if @task.can_start?
      @task.start!
      redirect_to task_path(@task)
    else
      render_403
    end
  end

  def finish
    if @task.can_finish?
      @task.finish!
      redirect_to task_path(@task)
    else
      render_403
    end
  end

  private

  def default_scope
    Task.where(user: current_user)
  end

  def find_task
    @task = default_scope.find(params[:id])
  end

  def check_access
    render_403 unless @task.user == current_user
  end

  def task_params
    params.require(:task).permit(:name, :description, attachments_attributes: [:id, :file, :_destroy])
  end
end
