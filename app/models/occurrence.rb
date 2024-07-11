class Occurrence < ApplicationRecord
  COMPLETION_STATUSES = %w[pending completed].freeze
  belongs_to :habit

  validates :date, presence: true
  validates :habit_id, presence: true
  validates :completion_status, inclusion: { in: COMPLETION_STATUSES }
  # validates uniqueness of date scoped to habit
  validates :date, uniqueness: { scope: :habit_id }

  has_one :habit_static, through: :habit

  # validates default status to pending
  after_initialize :set_default_completion_status, if: :new_record?

  # callback to update habit_statics record when an occurrence is saved
  private

  def set_default_completion_status
    self.completion_status ||= 'pending'
  end

end
