class RedactorUpload < ActiveRecord::Base
  
  image_accessor :file
  validates_property :format, :of => :image, :in => [:jpeg, :jpg, :png, :gif], :message => "must be an image"
  validate :file_uid, :presence => true
  
  def image
    file_type == 'image' ? file : nil
  end
end