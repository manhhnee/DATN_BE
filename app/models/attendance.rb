# frozen_string_literal: true
class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :attendance_type

  validates :date, :time_check, presence: true
end
