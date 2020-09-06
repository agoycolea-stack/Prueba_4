class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :retweets, dependent: :destroy
  validates :content, presence: true
  paginates_per 50
  

  scope :tweets_for_me, -> (user) { where(user_id: user.followings.ids) }


  def array_hashtags 

    hashtag = [ ]
    self.content.split (" ").each do |word|
      if word.start_with("#")
        
        word = link_to(word,"tweets?search#{word}")
      end
    hashtag.push(word)
    end
  end

end
