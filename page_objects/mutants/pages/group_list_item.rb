module Mutants
  module Pages
    class GroupListItem < SitePrism::Section
      element :id,                "td:nth-of-type(1)"
      element :name,              "td:nth-of-type(2)"
      element :number_of_mutants, "td:nth-of-type(3) span#number_of_mutants"
      element :number_of_tasks,   "td:nth-of-type(4) span#number_of_tasks"

      element :delete,    "td:nth-of-type(5) a[name='delete-task']"
      element :edit_page, "td:nth-of-type(2) a"

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

      alias_method :orig_number_of_tasks, :number_of_tasks
      def number_of_tasks
        orig_number_of_tasks.text.to_i
      end
    end
  end
end