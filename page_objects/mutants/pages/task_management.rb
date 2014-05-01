module Mutants
  module Pages

    class TaskManagement < SitePrism::Page
      set_url "/tasks"

      sections :task_list_items, Mutants::Pages::TaskListItem, "#task_list tbody tr"
    end
  end
end