module ApplicationHelper

  # あとで直す
  def image_url_helper(image)
    Rails.env.development? ? url_for(image) : image
  end
end
