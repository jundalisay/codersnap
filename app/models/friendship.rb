class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def mutual_friends
    friends.where(id: inverse_friends.map { |inverse| inverse.id })
  end

  def mutual_friendships
    friendships.where(friend_id: inverse_friendships.map { |inverse| inverse.user_id })
  end

  def pending_friends
    friends.where.not(id: inverse_friends.map { |inverse| inverse.id})
  end

  def friend_requests
    inverse_friends.where.not(id: friends.map { |friend| friend.id})
  end

  def friend_request_count
    request_total = inverse_friends.count - mutual_friends.count
  end

  def friend_request?(friendship)
    inverse = Friendship.where(friend: friendship.user, user: friendship.friend)
    if inverse.count == 0 || inverse.first.created_at > friendship.created_at
      true
    else
      false
    end
  end
end
