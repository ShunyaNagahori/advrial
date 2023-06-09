class Advrial < ApplicationRecord
  before_create :set_id
  
  belongs_to :user
  belongs_to :advrial_category
  has_many :advrial_places
  has_many :places, through: :advrial_places
  has_one_attached :main_visual

  validates :title, presence: true
  validate :start_date_cannot_comes_after_end_date
  

  def start_date_cannot_comes_after_end_date
    if self.start_date.present? && self.end_date.present?
      if (end_date - start_date).negative?
        errors.add :base, :comes_after_start_date
      end
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["advrial_category_id", "completed_trip", "created_at", "description", "end_date", "id", "public", "start_date", "title", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["advrial_category", "main_visual_attachment", "main_visual_blob", "places", "user"]
  end

  def set_id
    while self.id.blank? || Advrial.find_by(id: self.id).present?
      self.id = SecureRandom.urlsafe_base64
    end
  end
end
