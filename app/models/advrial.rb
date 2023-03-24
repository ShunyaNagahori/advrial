class Advrial < ApplicationRecord
  belongs_to :user
  belongs_to :advrial_category
  has_one_attached :main_visual

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_date_cannot_comes_after_end_date
  

  def start_date_cannot_comes_after_end_date
    if (end_date - start_date).negative?
      errors.add :base, :comes_after_start_date
    end
  end
end
