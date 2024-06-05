# frozen_string_literal: true
class Department < ApplicationRecord
  has_many :users
  validates :department_name, presence: true
end
