namespace :seeds do
  require 'csv'

  # カテゴリーの作成と編集
  desc "create AdvrialCategory"
  task advrial_category_create: :environment do
    path = File.join(Rails.root, 'lib/assets/csv/AdvrialCategory_2023_04_09.csv')
    ActiveRecord::Base.transaction do
      CSV.foreach(path, headers: true) do |data|
        advrial_category = AdvrialCategory.find_or_initialize_by(display_order: data['display_order'])
        is_new = advrial_category.new_record?
        advrial_category.update!(
          name_ja: data["name_ja"].presence,
          name_en: data["name_en"].presence,
          display_order: data["display_order"].presence,
        )
        if is_new
          puts "#{advrial_category.name_ja} Created" 
        else
          puts "#{advrial_category.name_ja} Updated"
        end
      end
    end
  end

  # returns_home_atがないものを、アップデート（いずれ消す）
  desc "Edit returns_home_at"
  task returns_home_update: :environment do
    ActiveRecord::Base.transaction do
      advrials = Advrial.where(completed_trip: true, returns_home_at: nil)
      advrials.each do |advrial|
        advrial.update!(returns_home_at: Time.current)
        puts "#{advrial.title} update" 
      end
    end
  end

  desc "place user references"
  task place_in_user_id: :environment do
    ActiveRecord::Base.transaction do
      Place.unscoped.all.each do |place|
        user_id = place.advrial.user.id
        place.update!(user_id: user_id)
        p "Update #{place.id}"
      end
    end
  end
end
