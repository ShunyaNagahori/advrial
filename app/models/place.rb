class Place < ApplicationRecord
  belongs_to :advrial
  has_many_attached :images

  validates :place_name, presence: true
  validates :address, presence: true
  validates :date_time, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validate :place_date_time_in_advrial


  def place_date_time_in_advrial
    if self.date_time > (self.advrial.end_date + 1) || self.date_time < self.advrial.start_date
      errors.add(:date_time, :place_date_time_in_advrial)
    end
  end
end
