module Mutants
  class GroupsController < ApplicationController
    def new
      @group = Mutants::Group.new
    end

    def create
      @group = Mutants::Group.new(group_params)
      if @group.save
        flash[:success] = 'Group has been created successfully!'
        redirect_to edit_group_url(@group)
      else
        flash.now[:error] = 'Group cannot be created'
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @group = Mutants::Group.find(params[:id])
    end

    def update
      @group = Mutants::Group.find(params[:id])
      if @group.update_attributes group_params
        flash[:success] = 'Group has been successfully updated'
        redirect_to edit_group_url(@group)
      else
        flash.now[:error] = 'Cannot update Group'
        render :edit, status: :unprocessable_entity
      end
    end

    def index
      q = params[:q]
      query = Mutants::Group.order(:name)
      query = query.where("name ilike ?", "%#{params[:q]}%") if q.present?
      @groups = query
    end
    
    def destroy
      @group = Mutants::Group.find(params[:id])
      if @group.destroy
        flash[:success] = 'Group has been successfully deleted!'
        redirect_to groups_url
      else
        flash[:error] = 'Cannot delete Group!'
        redirect_to groups_url
      end
    end

    private

    def group_params
      params.require(:mutants_group).permit(:name, mutant_ids: [], task_ids: [])
    end
  end
end