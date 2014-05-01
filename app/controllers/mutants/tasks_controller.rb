module Mutants
  class TasksController < ApplicationController
    def index
      @tasks = Task.order(:id).all
    end
  end
end