class Relationship < ApplicationRecord
  # フォローされている人
  belongs_to :follower, class_name: 'User', foreign_key: :follower_id
  # フォローされている人
  belongs_to :followed, class_name: 'User', foreign_key: :followed_id



  def set_id
    while self.id.blank? || Advrial.find_by(id: self.id).present?
      self.id = SecureRandom.urlsafe_base64
    end
  end
end
