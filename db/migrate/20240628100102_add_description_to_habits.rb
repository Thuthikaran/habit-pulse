class AddDescriptionToHabits < ActiveRecord::Migration[7.1]
  def change
    add_column :habits, :description, :text
  end
end
