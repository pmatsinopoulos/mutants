module Mutants
  module Pages
    class ApplicationPage < SitePrism::Page
      element :flash,     "#flash #flash_message"

      alias_method :orig_flash, :flash
      def flash
        orig_flash.text
      end
    end
  end
end