class AdvrialCategory < ApplicationRecord
  before_create :set_id
  has_many :advrials

  def name_in_locales(locale: [:ja, :en])
    locale == :ja ? name_ja : name_en
  end

  def set_id
    while self.id.blank? || Advrial.find_by(id: self.id).present?
      self.id = SecureRandom.base36
    end
  end
end
