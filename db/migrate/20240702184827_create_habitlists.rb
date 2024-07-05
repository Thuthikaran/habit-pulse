class CreateHabitlists < ActiveRecord::Migration[7.1]
  def change
    create_table :habitlists do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.date :due_date

      t.timestamps
    end
  end
end
