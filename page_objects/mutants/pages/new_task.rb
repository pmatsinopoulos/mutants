module Mutants
  module Pages
    class NewTask < Mutants::Pages::ApplicationPage
      set_url '/tasks/new'

      element :task_name, "#task_form #task_name"
      element :save,      "#task_form #save_task"
      element :task_list, '#task_list'

      def displayed?
        page.html.match /form.+task_form/
      end

    end
  end
end