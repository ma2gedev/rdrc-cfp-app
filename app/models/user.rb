# frozen_string_literal: true

class User < ApplicationRecord
  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
  validates :bio,   presence: true, on: :update

  has_many :papers,  inverse_of: :user
  has_many :reviews, inverse_of: :user

  enum role: [:speaker, :cleaner, :reviewer, :curator].freeze

  def self.create_from_auth!(auth)
    create! do |user|
      user.name       = auth.dig(:info, :name)
      user.email      = auth.dig(:info, :email)
      user.avatar_url = auth.dig(:extra, :raw_info, :avatar_url)
    end
  end
end
