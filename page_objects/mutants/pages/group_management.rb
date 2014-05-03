module Mutants
  module Pages

    class GroupManagement < Mutants::Pages::ApplicationPage
      set_url "/groups"
      set_url_matcher /\/groups\Z/

      element  :search_box,                                      '#search_box'
      element  :search_button,                                   '#search_button'
      element  :create_new_group,                                '#new_group'
      sections :group_list_items, Mutants::Pages::GroupListItem, '#group_list tbody tr'
    end
  end
end