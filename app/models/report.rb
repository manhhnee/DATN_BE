# app/models/report.rb

class Report < ApplicationRecord
  belongs_to :user
  belongs_to :attendance_type

  validates :date, presence: true
  validates :time_check, presence: true, if: :approved?

  scope :pending_approval, -> { where(approved: false) }

  def approve_and_create_attendance!
    return false if approved?

    transaction do
      create_attendance_from_report
      update(approved: true)
    end
  end

  def create_attendance_from_report
    attendance_params = {
      user_id:,
      date:,
      attendance_type_id:,
      time_check:
    }
    Attendance.create!(attendance_params)
  end

  def reject_report!
    return false if approved?

    destroy
  end
end
