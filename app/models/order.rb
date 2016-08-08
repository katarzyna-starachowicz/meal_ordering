require 'uri'

class Order < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many   :meals

  STATUS = %w(booking finalized ordered delivered).freeze

  validates :restaurant_name, presence: true
  validates :restaurant_link, format: { with: /\A#{URI.regexp(%w(http https))}\z/ }
  validates :status,          inclusion: { in: STATUS }
end
