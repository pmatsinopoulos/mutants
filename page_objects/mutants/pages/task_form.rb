module Mutants
  module Pages
    class TaskForm < Mutants::Pages::ApplicationPage
      element :task_name, "#task_form #task_name"
      element :save,      "#task_form input[type='submit']"
      element :task_list, "a[href='/tasks']"

      def displayed?
        page.html.match /form.+task_form/
      end

    end
  end
end