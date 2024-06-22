class Holiday < ApplicationRecord
  validates :holiday_date, presence: true, uniqueness: true
  validates :description, presence: true
end
