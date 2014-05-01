class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :tasks, [:name], unique: true, name: 'tasks_name_uidx'
  end
end
