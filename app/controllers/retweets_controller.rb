class ReretweetsController < ApplicationController
  before_action :set_like, only: [:show, :edit, :update, :destroy]

  def index
    @retweet = Retweet.all
    
  end

  def show
  end

  def new
    @retweet = Retweet.new
    
  end

  
  def edit
  end


  def create
    tweet = Tweet.find_by(id:params[:format])
    tweet_id = tweet.id
    user_id = current_user.id
    have_retweet = Retweet.where(user_id: user_id, tweet_id: tweet_id).present?

    if have_retweet && tweet.retweets_count > 0
      tweet.retweets_count = tweet.retweets_count -1
    else
      Retweet.create(user_id:user_id, tweet_id:tweet_id)
      tweet.retweets_count = tweet.retweets_count +1
    end

    redirect_to root_path
    tweet.save

  end


  def update
    respond_to do |format|
      if @retweet.update(retweet_params)
        format.html { redirect_to @retweet, notice: 'Retweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @retweet }
      else
        format.html { render :edit }
        format.json { render json: @retweet.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @retweet.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_retweet
      @retweet = Retweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def retweet_params
      params.require(:retweet).permit(:tweet_id, :user_id)
    end
end
