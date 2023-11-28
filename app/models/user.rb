class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties
  has_many :movies, through: :parties
  validates :name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email

end