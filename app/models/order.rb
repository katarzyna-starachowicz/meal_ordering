require 'uri'

class Order < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many   :meals

  STATUS = %w(booking finalized ordered delivered).freeze

  validates :restaurant_name, presence:  true
  validates :restaurant_link, format:    { with: /\A#{URI.regexp(%w(http https))}\z/ }
  validates :status,          inclusion: { in: STATUS }

  scope :deleted,     -> { where.not(deleted_at: nil) }
  scope :not_deleted, -> { where(deleted_at: nil) }

  scope :active, ->  { where(status: 'booking').not_deleted }
  scope :history, -> { where('status!=? OR deleted_at IS NOT NULL', 'booking') }
end
