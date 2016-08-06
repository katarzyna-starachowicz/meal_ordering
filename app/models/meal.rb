class Meal < ActiveRecord::Base
  belongs_to :order
  belongs_to :client, class_name: 'User'

  validates :name,  presence: true
  validates :price, presence: true
end
