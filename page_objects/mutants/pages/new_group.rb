module Mutants
  module Pages
    class NewGroup < Mutants::Pages::GroupForm
      set_url '/groups/new'
      set_url_matcher /\/groups\/new/
    end
  end
end