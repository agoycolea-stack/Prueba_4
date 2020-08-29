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
    @like = Like.new(like_params)
    @like.user = current_user

    respond_to do |format|
      if @like.save
        format.html { redirect_to @like, notice: 'Like was successfully created.' }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { render :new }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @like.update(Like_params)
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
