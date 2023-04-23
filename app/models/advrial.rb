class Advrial < ApplicationRecord
  before_create :set_id
  belongs_to :user
  belongs_to :advrial_category
  has_one_attached :main_visual
  has_many :places, dependent: :destroy

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :returns_home_at, presence: true, if: proc{ |advrial| advrial.completed_trip? }
  validate :start_date_cannot_comes_after_end_date
  

  def start_date_cannot_comes_after_end_date
    if self.start_date.present? && self.end_date.present?
      if (end_date - start_date).negative?
        errors.add :base, :comes_after_start_date
      end
    end
  end

  def set_id
    while self.id.blank? || Advrial.find_by(id: self.id).present?
      self.id = SecureRandom.urlsafe_base64
    end
  end
end
