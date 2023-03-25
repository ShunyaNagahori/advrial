class Place < ApplicationRecord
  belongs_to :advrial
  has_many_attached :images

  validates :place_name, presence: true
end
