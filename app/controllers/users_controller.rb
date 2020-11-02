class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end
        if @isRoom
        else
          @room = Room.new
          @entry = Entry.new
        end
      end
    end

  def following
    @user  = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end
end
