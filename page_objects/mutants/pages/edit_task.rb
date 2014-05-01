module Mutants
  module Pages
    class EditTask < SitePrism::Page
      set_url "/tasks/{:id}/edit"
      set_url_matcher /\/tasks\/\d+\/edit/

      element :flash, '#flash #flash_message'

      alias_method :orig_flash, :flash
      def flash
        orig_flash.text
      end
    end
  end
end