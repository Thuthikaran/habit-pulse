class Occurrence < ApplicationRecord
  COMPLETION_STATUSES = %w[pending completed missed].freeze
  belongs_to :habit

  validates :date, presence: true
  validates :habit_id, presence: true
  validates :completion_status, inclusion: { in: COMPLETION_STATUSES }

  has_one :habit_static, through: :habit

  # validates default status to pending
  after_initialize :set_default_completion_status, if: :new_record?

  # callback to update habit_statics record when an occurrence is saved
  after_save :update_habit_statics


  private

  def set_default_completion_status
    self.completion_status ||= 'pedning'
  end

  def update_habit_statics
    habit_static = self.habit_static
    if self.completion_status == 'completed'
      habit_static.total_occurrences = (habit_static.total_occurrences || 0) + 1
      habit_static.completed_occurrences = (habit_static.completed_occurrences || 0) + 1
    elsif self.completion_status == 'missed'
      habit_static.total_occurrences = (habit_static.total_occurrences || 0) + 1
      habit_static.missed_occurrences = (habit_static.missed_occurrences || 0) + 1
    end
    habit_static.save
  end
end
