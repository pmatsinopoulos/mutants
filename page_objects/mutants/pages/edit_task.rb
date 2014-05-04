module Mutants
  module Pages
    class EditTask < Mutants::Pages::TaskForm
      set_url "/tasks{/id}/edit"
      set_url_matcher /\/tasks\/\d+\/edit/
    end
  end
end
