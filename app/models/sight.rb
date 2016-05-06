class Sight < ActiveRecord::Base
  has_many :reviews
  has_many :user_sights
  has_many :users, through: :user_sights
end