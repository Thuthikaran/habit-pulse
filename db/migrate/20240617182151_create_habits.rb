class CreateHabits < ActiveRecord::Migration[7.1]
  def change
    create_table :habits do |t|
      t.string :name
      t.integer :priority
      t.date :start_date
      t.date :end_date
      t.time :reminder
      t.string :frequency
      t.string :status
      t.string :category
      t.references :user, null: false, foreign_key: true
      t.string :days_of_week

      t.timestamps
    end
  end
end
