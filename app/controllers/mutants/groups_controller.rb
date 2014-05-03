module Mutants
  class GroupsController < ApplicationController
    def new
      @group = Mutants::Forms::Groups::New.new
    end

    def create
      form_group = Mutants::Forms::Groups::New.new(group_params)
      @group = form_group.initialize_group
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

    def index
      @groups = Mutants::Group.order(:name)
    end

    private

    def group_params
      params.require(:mutants_forms_groups_new).permit(:name, mutants: [], tasks: [])
    end
  end
end