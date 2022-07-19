class TaskListsController < ApplicationController
  before_action :set_task_list, only: %i[ show edit update destroy ]

  def index
    @task_lists = TaskList.all
    debugger
    respond_to do |format|
      format.html
      format.json { render :json => @task_lists.to_json(:include => :tasks) }
    end
  end

  def new
    @task_list = TaskList.new
  end

  def edit
  end

  def create
    @task_list = TaskList.new(task_list_params)

    if @task_list.save
      redirect_to task_lists_url, notice: "Task list was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task_list.update(task_list_params)
      redirect_to task_lists_url, notice: "Task list was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task_list.destroy

    redirect_to task_lists_url, notice: "Task list was successfully destroyed."
  end

  private
    def set_task_list
      @task_list = TaskList.find(params[:id])
    end

    def task_list_params
      params.require(:task_list).permit(:name)
    end
end
