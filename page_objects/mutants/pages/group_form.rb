module Mutants
  module Pages
    class GroupForm < Mutants::Pages::ApplicationPage
      element :name,          '#name'
      element :mutants,       '#mutants'
      element :tasks,         '#tasks'
      element :create_button, "input[type='submit']"
      element :update,        "input[type='submit']"
      element :groups,        "a[href='/groups']"
      element :new_task_link, "#new_task_link"

      element :modal_dialog,  "#modal_dialog"
      element :new_task_name, "#task_name"
      element :save,          "#save_task"
      elements :task_details, "#tasks option"
      elements :selected_tasks, "#tasks option[selected='selected']"

      def selected_task_names
        selected_tasks.map{|t| t.text}
      end
    end
  end
end