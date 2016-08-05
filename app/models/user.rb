class User < ActiveRecord::Base
  has_many :meals,  foreign_key: 'client_id',  class_name: 'Meal'
  has_many :orders, foreign_key: 'creator_id', class_name: 'Order'

  validates :provider, :uid, :name, presence: true
  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(provider: auth_hash.provider, uid: auth_hash.uid, name: auth_hash.info.name).first_or_create
  end
end
