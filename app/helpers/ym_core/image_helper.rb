module YmCore::ImageHelper
  
  # TODO: get this working
  # def holding_image(geo_string, options = {})
  #   filename = File.dirname(__FILE__) + "/../../assets/images/holding.png"
  #   image_tag(Dragonfly[:images].fetch(filename).thumb(geo_string).url, options)
  # end
  
  def image_placeholder(geo_string, options = {})
    width, height = width_height_from_geo_string(geo_string)
    image_url = "http://placehold.it/#{[width,height].compact.join('x')}"
    options[:image_url] ? "" : image_tag(image_url, options)
  end
  
  def image_for(object, geo_string, options = {})
    if object.image
      image_tag(object.image.thumb(geo_string).url, options)
    else
      image_placeholder(geo_string, options)
    end
  end
  
  def width_height_from_geo_string(geo_string)
    res = geo_string.blank? ? nil : geo_string.match(/(\d+)x?(\d*)/)
    res ? [(res[1].blank? ? nil : res[1].to_i), (res[2].blank? ? nil : res[2].to_i)] : [nil, nil]
  end
  
end