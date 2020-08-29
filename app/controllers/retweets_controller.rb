class ReretweetsController < ApplicationController
  before_action :set_reretweet, only: [:show, :edit, :update, :destroy]

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
    @retweet = Retweet.new(retweet_params)

    respond_to do |format|
      if @retweet.save
        format.html { redirect_to @retweet, notice: 'Retweet was successfully created.' }
        format.json { render :show, status: :created, location: @retweet }
      else
        format.html { render :new }
        format.json { render json: @retweet.errors, status: :unprocessable_entity }
      end
    end
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
    respond_to do |format|
      format.html { redirect_to retweets_url, notice: 'Retweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_retweet
      @retweet = retweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def retweet_params
      params.require(:retweet).permit(:user_id, :tweet_id)
    end
end
