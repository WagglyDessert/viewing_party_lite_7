class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties
  has_many :movies, through: :parties
  validates :name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email
  validates :username, uniqueness: true, presence: true
  validates_presence_of :password

  has_secure_password

end