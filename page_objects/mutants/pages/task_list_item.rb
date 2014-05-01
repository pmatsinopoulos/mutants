module Mutants
  module Pages
    class TaskListItem < SitePrism::Section
      element :id,   "td:nth-of-type(1)"
      element :name, "td:nth-of-type(2)"

      alias_method :orig_id, :id
      def id
        orig_id.text
      end

      alias_method :orig_name, :name
      def name
        orig_name.text
      end
    end
  end
end