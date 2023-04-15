class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  before_save :set_file_extension

  def set_file_extension
    if image.attached? && !image.blob.filename.extension
      mime_type = image.blob.content_type.split("/").last
      extension = Rack::Mime::MIME_TYPES.invert[mime_type]
      image.blob.update(filename: "#{image.blob.filename}.#{extension}")
    end
  end
end
