class CreateHabitStatics < ActiveRecord::Migration[7.1]
  def change
    create_table :habit_statics do |t|
      t.references :habit, null: false, foreign_key: true
      t.integer :total_occurrences
      t.integer :completed_occurrences
      t.integer :missed_occurrences

      t.timestamps
    end
  end
end
