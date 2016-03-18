class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :edit, :update, :destroy]

  def create
    @friendship = if params.has_key? :friend_id
      current_user.friendships.build(friend_id: params.delete(:friend_id))
    else
      current_user.friendships.build(friend_id: params.delete(:user_id))
    end
    @valid = @friendship.save
    respond_to do |format|
      format.html do
        if @valid
          flash[:success] = "Friended #{@friendship.friend.username}."
        else
          flash[:error] = "Unable to add friend."
        end
        redirect_to :back
      end
      format.js do
        if current_user.mutual_friends.include? @friendship.friend
          @new_friend = @friendship.friend
          inverse_friendship = current_user.inverse_friendships.where(user: @friendship.friend).first
          @new_activity = current_user.activities.where(trackable_id: @friendship).first
          @activity = current_user.activities.where(trackable_id: inverse_friendship).first
        end
      end
    end
  end

  def destroy
    @friendship = current_user.friendships.find_by_friend_id(params[:id])
    @inverse_friendship = current_user.inverse_friendships.find_by_user_id(params[:id])
    activity = current_user.activities.where(trackable: @inverse_friendship).first unless @inverse_friendship.nil?
    @activity_id = activity.id if activity
    activity.try(:destroy)
    friend = User.find(params[:id])
    message = "Unfriended #{ friend.username }."

    begin
      @friendship.destroy
    rescue
      message = "Rejected #{ friend.username }'s friend request."
    end
    begin
      @inverse_friendship.destroy
    rescue
      message = "Cancelled your friend request to #{ friend.username }."
    end

    respond_to do |format|
      format.html do
        flash[:success] = message
        redirect_to :back
      end
      format.js do
      end
    end
  end

  def index
    @search_form = params.has_key?(:search_form) ? SearchForm.new(search_params) : SearchForm.new
    @active_tab = params.delete(:active_tab) || session.delete(:active_tab) || 'mutual'
    @mutual = current_user.mutual_friends
    @requests = current_user.friend_requests
    @pending = current_user.pending_friends
    unless @search_form.search_for.blank?
      @mutual = @mutual.where(
        "lower(username) LIKE lower(?)",
        "#{Regexp.escape(@search_form.search_for)}%"
      )
      @requests = @requests.where(
        "lower(username) LIKE lower(?)",
        "#{Regexp.escape(@search_form.search_for)}%"
      )
      @pending = @pending.where(
        "lower(username) LIKE lower(?)",
        "#{Regexp.escape(@search_form.search_for)}%"
      )
    end
    respond_to do |format|
      format.html do
        @mutual = @mutual.paginate(page: params[:mutual_page])
        @requests = @requests.paginate(page: params[:requests_page])
        @pending = @pending.paginate(page: params[:pending_page])
      end
      format.js do
        @mutual = @mutual.paginate(page: nil)
        @requests = @requests.paginate(page: nil)
        @pending = @pending.paginate(page: nil)
        render 'friends'
      end
    end
  end

  def friends
    session[:active_tab] = 'mutual'
    redirect_to friendships_path
  end

  def requests
    session[:active_tab] = 'requests'
    redirect_to friendships_path
  end

  def pending
    session[:active_tab] = 'pending'
    redirect_to friendships_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friendship_params
      params.fetch(:friendship, {})
    end
end
