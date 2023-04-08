namespace :seeds do
  require 'csv'

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
          puts "#{advrial_category.name_en} Updated"
        end
      end
    end
  end

end
