# frozen_string_literal: true
class Note < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :label, presence: true
  validates :day, presence: true
end
