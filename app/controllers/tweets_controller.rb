class TweetsController < ApplicationController

  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  acts_as_token_authentication_handler_for User

  def index
    #https://github.com/activerecord-hackery/ransack



    if !current_user
      @q = Tweet.ransack(params[:q])
      @tweets = @q.result(distinct: true).page(params[:page])
    else
      @q = Tweet.tweets_for_me(current_user).ransack(params[:q])
      @tweets = @q.result(distinct:true).page(params[:page])
      @tweet = Tweet.new
    end
  end


  def show
    #@user = @user.image_url
  end

  def new
    @tweet = Tweet.new
    
  end

  
  def edit
  end


  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @tweet.update(Tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :likes_count, :retweets_count, :user)
    end

end
