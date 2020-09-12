class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token

  def news

    @tweets = Tweet.order(created_at: :asc).last(50).reverse do |tweet| {
      id: tweet.id, 
      content: tweet.content, 
      user: tweet.user_id,  
      like_count: tweet.likes_count,
      retweets: tweet.retweets_count,
      retweeted_from: Tweet.joins(retweets).user_id
    }
    end



    if @tweets
      render json: @tweets
    else
      render json: 'error',status: 400
    end

  end

  def dates

    from = Date.parse(params[:from],("%Y-%m-%d"))
    to = Date.parse(params[:to],("%Y-%m-%d"))

    tweets = Tweet.where(created_at: from..to)

      if tweets
      render json: tweets
    else
      render json: 'error',status: 400
    end

  end

  def tweets
    user = User.authenticate(params[:email], params[:password])
    @tweet = Tweet.new(tweet_params)
    @tweet.user = user
  end


  private
  def tweet_params
    params.require(:tweet).permit(:content, :user_id, :like_count, :retweets_count)
  end

end
