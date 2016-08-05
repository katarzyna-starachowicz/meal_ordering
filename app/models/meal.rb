class Meal < ActiveRecord::Base
  belongs_to :order
  belongs_to :client, class_name: 'User'

  validates :name, presence: true
  validates :price,
    presence: true,
    format: { with: /\A\d+(?:\.\d{2})?\z/ },
    numericality: { greater_than: 0, less_than: 1000_000 }
end
