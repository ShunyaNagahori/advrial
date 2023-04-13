class Relationship < ApplicationRecord
  # フォローされている人
  belongs_to :follower, class_name: 'User', foreign_key: :follower_id
  # フォローされている人
  belongs_to :followed, class_name: 'User', foreign_key: :followed_id
end
