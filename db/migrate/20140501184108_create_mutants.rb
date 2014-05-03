class CreateMutants < ActiveRecord::Migration
  def change
    create_table :mutants do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :mutants, [:name], unique: true, name: 'mutants_name_uidx'
  end
end
