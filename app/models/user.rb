# frozen_string_literal: true
class User < ApplicationRecord
  belongs_to :department

  has_one_attached :avatar
  has_many :attendances, dependent: :destroy
  has_many :face_data, class_name: "FaceDatum", dependent: :destroy
  has_many :notes, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :password, presence: true, confirmation: true, on: :create

  has_secure_password

  enum role: { admin: 1, customer: 2 }

  before_validation :set_default_role, if: :new_record?

  def self.authenticate(email, password)
    user = find_by(email:)
    user if user&.authenticate(password)
  end

  def generate_jwt(remember)
    expiration_time = remember ? 10.days.to_i : 30.minutes.to_i
    exp = Time.now.to_i + expiration_time
    payload = { id:, exp: }
    JWT.encode(payload, Rails.application.secret_key_base)
  end

  def avatar_url
    return unless avatar.attached?

    Rails.application.routes.url_helpers.rails_blob_url(avatar, only_path: true)
  end

  private

  def set_default_role
    self.role ||= :customer
  end
end
