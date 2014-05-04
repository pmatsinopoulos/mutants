module Mutants
  class TasksController < ApplicationController
    def index
      q = params[:q]
      query = Mutants::Task.order(:name)
      query = query.where("name like ?", "%#{params[:q]}%") if q.present?
      @tasks = query
    end

    def new
      @task = Mutants::Task.new
    end

    def create
      @task = Mutants::Task.new task_params
      if @task.save
        flash[:notice] = "Task has been created successfully!"
        redirect_to edit_task_url(@task)
      else
        flash.now[:alert] = "Cannot create task!"
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @task = Mutants::Task.find(params[:id])
    end

    def update
      @task = Mutants::Task.find(params[:id])
      if @task.update_attributes task_params
        flash[:notice] = "Task has been successfully updated!"
        redirect_to edit_task_url(@task)
      else
        flash.now[:alert] = "Cannot update task!"
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @task = Mutants::Task.find(params[:id])
      if @task.destroy
        redirect_to tasks_url, notice: 'Task has been successfully deleted!'
      else
        redirect_to tasks_url, alert: 'Cannot delete task!'
      end
    end

    private

    def task_params
      params.require(:mutants_task).permit(:name)
    end
  end
end