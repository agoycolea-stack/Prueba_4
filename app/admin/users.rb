ActiveAdmin.register User do

  permit_params :email, :name, :tweets, :likes, :tweet_id, :remember_created_at
  
  index do
    selectable_column
    id_column
    column :email
    column :name
    column :FLLWNG do |user|
      user.followings.count
    end
    
    column :TWTS do |user|
      user.tweets.count
    end
    
    #no pude hacer los retweets en la entrega pasada, por lo que siempre sera cero :( 
    column :RTWTS do |user|
      user.retweets.count
    end
    
    column :Likes do |user|
      user.likes.count
    end
    actions
  end

end
