class ChangeDaysOfWeekInHabits < ActiveRecord::Migration[7.1]
  def up
    remove_column :habits, :days_of_week
    add_column :habits, :days_of_week, :string, array: true, default: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
  end

  def down
    remove_column :habits, :days_of_week
    add_column :habits, :days_of_week, :previous_type, default: previous_default
  end
end
