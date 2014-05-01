module Mutants
  module Pages
    class NewTask < SitePrism::Page
      set_url '/tasks/new'

      element :task_name, "#new_task_form #task_name"
      element :save,      "#new_task_form #save_task"
    end
  end
end