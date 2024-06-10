# frozen_string_literal: true
class Salary < ApplicationRecord
  belongs_to :user

  validates :date, presence: true
  validates :total_salary, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
