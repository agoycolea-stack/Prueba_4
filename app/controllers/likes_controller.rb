class LikesController < ApplicationController
  before_action :set_like, only: [:show, :edit, :update, :destroy]

  def index
    @like = Like.all
  end

  def show
  end

  def new
    @like = Like.new

  end

  
  def edit
  end


  def create

    tweet = Tweet.find_by(id:params[:format])

    user_id = current_user.id

    tweet_id = tweet.id

    have_like = Like.where(user_id: user_id, tweet_id: tweet_id).present?

    if have_like && tweet.likes_count > 0

      tweet.likes_count = tweet.likes_count - 1

    else

      Like.create(user_id:user_id, tweet_id:tweet_id)

      tweet.likes_count = tweet.likes_count + 1

    end

  redirect_to root_path
  tweet.save

  end


  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @like, notice: 'Like was successfully updated.' }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
  
      @like.destroy
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.require(:like).permit(:tweet_id, :user_id)
    end

end
