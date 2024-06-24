class AddDefaultToCompletionStatus < ActiveRecord::Migration[7.1]
  def change
    # change completion_status to be default 'pending'
    change_column_default :occurrences, :completion_status, 'pending'

  end
end
