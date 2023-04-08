class AdvrialCategory < ApplicationRecord
  before_create :set_id
  has_many :advrials

  validates :name_ja, presence: true
  validates :name_en, presence: true


  def name_in_locales
    I18n.locale == :ja ? name_ja : name_en
  end

  def set_id
    while self.id.blank? || Advrial.find_by(id: self.id).present?
      self.id = SecureRandom.base36
    end
  end

  before_validation do
    self.display_order ||= (AdvrialCategory.maximum(:display_order) || -1) + 1 # まだ他のrecordが存在しない場合は0を返す
  end

end
