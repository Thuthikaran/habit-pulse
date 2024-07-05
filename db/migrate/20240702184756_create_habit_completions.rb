class CreateHabitCompletions < ActiveRecord::Migration[7.1]
  def change
    create_table :habit_completions do |t|
      t.references :habit, null: false, foreign_key: true
      t.boolean :completed
      t.date :completed_at

      t.timestamps
    end
  end
end
