class HabitStatic < ApplicationRecord
  belongs_to :habit

  # do not allow destroy if it has habit associated


end
