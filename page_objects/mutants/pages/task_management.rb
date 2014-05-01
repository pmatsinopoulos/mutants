module Mutants
  module Pages

    class TaskManagement < SitePrism::Page
      set_url "/tasks"

      element  :search_box,                                    '#search_box'
      element  :search_button,                                 '#search_button'
      sections :task_list_items, Mutants::Pages::TaskListItem, '#task_list tbody tr'
    end
  end
end