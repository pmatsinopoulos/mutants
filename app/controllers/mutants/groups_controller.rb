module Mutants
  class GroupsController < ApplicationController
    def new
      @group = Mutants::Group.new
    end

    def create
      @group = Mutants::Group.new(group_params)
      if @group.save
        redirect_to edit_group_path(@group), :notice => 'Group has been created successfully'
      else
        flash.now[:alert] = 'Group cannot be created'
        render :new
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
        render :edit
      end
    end

    def index
      @groups = Mutants::Group.order(:name)
    end

    private

    def group_params
      params.require(:mutants_group).permit(:name, mutant_ids: [], task_ids: [])
    end
  end
end