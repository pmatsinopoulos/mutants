module Mutants
  module Pages
    class NewTask < SitePrism::Page
      set_url '/tasks/new'

      element :task_name, "form#new_task_form input#task_name"

    end
  end
end