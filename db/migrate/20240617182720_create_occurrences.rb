class CreateOccurrences < ActiveRecord::Migration[7.1]
  def change
    create_table :occurrences do |t|
      t.string :completion_status
      t.date :date
      t.references :habit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
