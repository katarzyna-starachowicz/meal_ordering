require 'uri'

class Order < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many   :meals

  validates :restaurant,      presence: true
  validates :status,          inclusion: { in: %w(booking finalized ordered delivered) }
  validates :restaurant_link, format: { with: /\A#{URI.regexp(%w(http https))}\z/ }
end
