class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :likes, dependent: :destroy
  has_many :tweets, dependent: :destroy
  has_many :retweets,dependent: :destroy
  
  has_many :fans, foreign_key: :user_following_id, class_name: "FollowerFollowing"
  has_many :followers, through: :fans, source: :follower


  has_many :backing, foreign_key: :user_follower_id, class_name: "FollowerFollowing"
  has_many :followings, through: :backing, source: :following

  def to_s
    name
  end
  
end
