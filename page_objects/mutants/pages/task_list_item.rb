module Mutants
  module Pages
    class TaskListItem < SitePrism::Section
      element :id,                "td:nth-of-type(1)"
      element :name,              "td:nth-of-type(2)"
      element :number_of_mutants, "td:nth-of-type(3) span#number_of_mutants"
      element :delete,            "td:nth-of-type(4) a[name='delete-task']"
      element :edit_page,         "td:nth-of-type(2) a"

      alias_method :orig_id, :id
      def id
        orig_id.text.to_i
      end

      alias_method :orig_name, :name
      def name
        orig_name.text
      end

      alias_method :orig_number_of_mutants, :number_of_mutants
      def number_of_mutants
        orig_number_of_mutants.text.to_i
      end
    end
  end
end