class Order < ActiveRecord::Base
  validates :restaurant, presence: true
end
