class Place < ApplicationRecord
  before_create :set_id
  
  belongs_to :user
  has_many :advrial_places
  has_many :advrials, through: :advrial_places
  has_many_attached :images

  validates :place_name, presence: true
  validates :address, presence: true
  validates :date_time, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  # validate :place_date_time_in_advrial
  validate :image_length


  # def place_date_time_in_advrial
  #   if self.date_time.present?
  #     if self.date_time > (self.advrial.end_date + 1) || self.date_time < (self.advrial.start_date - 1)
  #       errors.add(:date_time, :place_date_time_in_advrial)
  #     end
  #   end
  # end

  def set_id
    while self.id.blank? || Advrial.find_by(id: self.id).present?
      self.id = SecureRandom.urlsafe_base64
    end
  end

  # FIXME: バリデーションは効くが、バリデーションエラーにならない(とりあえず、viewに説明を表示)
  def image_length
    if self.images.length > 5
      images.purge
      errors.add(:base, "test")
    end
  end
end
