module Mutants
  module Forms
    module Groups
      class New
        include ActiveModel::Model

        attr_accessor :name, :mutants, :tasks
        attr_writer   :mutants_to_select_from,
                      :tasks_to_select_from

        def mutants_to_select_from
          Mutants::Mutant.order(:name).all.map{|m| [m.name, m.id]}
        end

        def tasks_to_select_from
          Mutants::Task.order(:name).all.map{|t| [t.name, t.id]}
        end

        # @return [Mutants::Group]
        #
        def initialize_group
          result = Mutants::Group.new
          result.name = name
          result.mutant_ids = mutants
          result.task_ids   = tasks
          result
        end
      end
    end
  end
end