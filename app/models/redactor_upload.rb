class RedactorUpload < ActiveRecord::Base
  
  image_accessor :image
  validates_property :format, :of => :image, :in => [:jpeg, :jpg, :png, :gif], :message => "must be an image"
  validate :image_uid, :presence => true
  
end