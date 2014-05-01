module Mutants
  module Pages
    class NewTask < Mutants::Pages::ApplicationPage
      set_url '/tasks/new'

      element :task_name, "#new_task_form #task_name"
      element :save,      "#new_task_form #save_task"

      def displayed?
        page.html.match /new_task_form/
      end

    end
  end
end