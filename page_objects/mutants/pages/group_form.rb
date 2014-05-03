module Mutants
  module Pages
    class GroupForm < Mutants::Pages::ApplicationPage
      element :name,          '#name'
      element :mutants,       '#mutants'
      element :tasks,         '#tasks'
      element :create_button, "input[type='submit']"
      element :update,        "input[type='submit']"
      element :groups,        "a[href='/groups']"
    end
  end
end