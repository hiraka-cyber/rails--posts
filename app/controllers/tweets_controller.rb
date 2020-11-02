class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create]
  def index
      @tweets = Tweet.all
  end

  def show
      @tweet = Tweet.find(params[:id])
      @like = Like.new
  end

  def new
      @tweet = Tweet.new
  end

  def edit
      @tweet = Tweet.find(params[:id])
  end

  def create
      @tweet = Tweet.new(tweet_params)
      @tweet.user_id = current_user.id

      if @tweet.save
          redirect_to @tweet
      else
          render 'new'
      end
  end

  def update
      @tweet = Tweet.find(params[:id])

      if @tweet.update(tweet_params)
          redirect_to @tweet
      else
          render 'edit'
      end
  end

  def destroy
      @tweet = Tweet.find(params[:id])
      @tweet.destroy

      redirect_to tweets_path
  end

  def ensure_correct_user
      @post = Post.find_by(id:params[:id])
      if @post.user_id != @current_user.id
        flash[:notice] = "権限がありません"
        redirect_to tweets_path
    end
  end

  private
      def tweet_params
          params.require(:tweet).permit(:title, :text, :img, :remove_img, :user_id)
      end
end
