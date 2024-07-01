class AddDefaultToOccurrences < ActiveRecord::Migration[7.1]
  def change
    # change total_occurrences, missed_occurrences and coimpleted_occurrences to be default 0
    change_column_default :habit_statics, :total_occurrences, 0
    change_column_default :habit_statics, :missed_occurrences, 0
    change_column_default :habit_statics, :completed_occurrences, 0
  end
end
