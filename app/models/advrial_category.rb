class AdvrialCategory < ApplicationRecord
  has_many :advrials

  def name_in_locales(locale: [:ja, :en])
    locale == :ja ? name_ja : name_en
  end
end
