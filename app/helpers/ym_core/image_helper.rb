module YmCore::ImageHelper

  # TODO: get this working
  # def holding_image(geo_string, options = {})
  #   filename = File.dirname(__FILE__) + "/../../assets/images/holding.png"
  #   image_tag(Dragonfly[:images].fetch(filename).thumb(geo_string).url, options)
  # end

  def image_placeholder(geo_string, options = {})
    width, height = width_height_from_geo_string(geo_string)
    text_param = "&text=#{CGI.escape(options[:text])}" if options[:text].present?
    image_url = "http://placehold.it/#{[width,height].compact.join('x')}#{text_param}"
    options[:image_url] ? "" : image_tag(image_url, options)
  end

  def dragonfly_image_tag(*args)
    options = args.extract_options!
    image, geo_string = args[0], args[1]
    url = geo_string.blank? ? image.url : image.thumb(geo_string).url
    image_tag(url, options)
  end

  def image_for(*args)
    options = args.extract_options!
    object, geo_string = args[0], args[1]
    width, height = width_height_from_geo_string(geo_string)
    options.reverse_merge!(:alt => "#{(truncate(object.to_s || "", :length => (width || 50).to_i / 6))}", :method => 'image')
    image = object.send(options[:method])
    if image
      YmCore::ImageDownloader::download_image_if_missing(image) if Rails.env.development?
      dragonfly_image_tag(image, geo_string, options)
    elsif object.default_image
      dragonfly_image_tag(object.default_image, geo_string, options)
    else
      options[:text] = options.delete(:placeholder_text)
      image_placeholder(geo_string, options)
    end
  end

  def width_height_from_geo_string(geo_string)
    res = geo_string.blank? ? nil : geo_string.match(/(\d+)x?(\d*)/)
    res ? [(res[1].blank? ? nil : res[1].to_i), (res[2].blank? ? nil : res[2].to_i)] : [nil, nil]
  end

end