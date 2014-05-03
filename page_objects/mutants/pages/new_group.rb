module Mutants
  module Pages
    class NewGroup < Mutants::Pages::ApplicationPage
      set_url '/groups/new'
      set_url_matcher /\/groups\/new/

      element :name,          '#name'
      element :mutants,       '#mutants'
      element :tasks,         '#tasks'
      element :create_button, "input[type='submit']"
    end
  end
end