class User < ActiveRecord::Base
  has_many :tasks

  validates :email, :password, presence: true
end
