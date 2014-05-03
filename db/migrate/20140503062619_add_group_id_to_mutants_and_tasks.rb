class AddGroupIdToMutantsAndTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :group_id, :integer
    add_foreign_key :tasks, :groups, column: :group_id, name: 'tasks_group_fk'

    add_column :mutants, :group_id, :integer
    add_foreign_key :mutants, :groups, column: :group_id, name: 'tasks_mutant_fk'
  end
end
