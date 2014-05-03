module Mutants
  module Pages

    class GroupManagement < SitePrism::Page
      set_url "/groups"
      set_url_matcher /\/groups\Z/

      # element  :search_box,                                    '#search_box'
      # element  :search_button,                                 '#search_button'
      # element  :new_task,                                      '#new_task'
      sections :group_list_items, Mutants::Pages::GroupListItem, '#group_list tbody tr'
    end
  end
end