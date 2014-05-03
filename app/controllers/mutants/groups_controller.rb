module Mutants
  class GroupsController < ApplicationController
    def new
      @group = Mutants::Group.new
    end

    def create
      @group = Mutants::Group.new(group_params)
      if @group.save
        redirect_to edit_group_path(@group), notice: 'Group has been created successfully!'
      else
        flash.now[:alert] = 'Group cannot be created'
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @group = Mutants::Group.find(params[:id])
    end

    def update
      @group = Mutants::Group.find(params[:id])
      if @group.update_attributes group_params
        redirect_to edit_group_path(@group), :notice => 'Group has been successfully updated'
      else
        flash.now[:alert] = 'Cannot update Group'
        render :edit, status: :unprocessable_entity
      end
    end

    def index
      q = params[:q]
      query = Mutants::Group.order(:name)
      query = query.where("name like ?", "%#{params[:q]}%") if q.present?
      @groups = query
    end
    
    def destroy
      @group = Mutants::Group.find(params[:id])
      if @group.destroy
        redirect_to groups_path, :notice => 'Group has been successfully deleted!'
      else
        redirect_to groups_path, :alert => 'Cannot delete Group!'
      end
    end

    private

    def group_params
      params.require(:mutants_group).permit(:name, mutant_ids: [], task_ids: [])
    end
  end
end