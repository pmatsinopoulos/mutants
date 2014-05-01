module Mutants
  module Pages

    class TaskManagement < SitePrism::Page
      set_url "/tasks"
      set_url_matcher /\/tasks\Z/

      element  :search_box,                                    '#search_box'
      element  :search_button,                                 '#search_button'
      element  :new_task,                                      '#new_task'
      sections :task_list_items, Mutants::Pages::TaskListItem, '#task_list tbody tr'
    end
  end
end