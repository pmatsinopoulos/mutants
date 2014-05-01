module Mutants
  module Pages
    class EditTask < Mutants::Pages::ApplicationPage
      set_url "/tasks{/id}/edit"
      set_url_matcher /\/tasks\/\d+\/edit/

      element :task_name, '#task_form #task_name'
      element :update,    "#task_form input[type='submit']"
    end
  end
end
