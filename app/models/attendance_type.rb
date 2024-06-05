# frozen_string_literal: true
class AttendanceType < ApplicationRecord
  has_one :attendance

  validates :type_name, presence: true
end
