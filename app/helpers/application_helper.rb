module ApplicationHelper

  # あとで直す
  def image_url_helper(image)
    Rails.env.development? ? url_for(image) : url_for(image.url)
  end
end
