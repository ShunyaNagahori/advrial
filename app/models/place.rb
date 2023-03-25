class Place < ApplicationRecord
  belongs_to :advrial
  has_many_attached :images

  validates :name, presence: true
end
